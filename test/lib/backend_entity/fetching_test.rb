require 'test_helper'

module BackendEntity
  class FetchingTest < ActiveSupport::TestCase
    class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Fetching
    end

    class ::AnotherExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Fetching
    end

    describe 'Fetching entities' do
      before do
        @controller = ::ExamplesController.new
      end

      it 'lists entities' do
        assert_equal 'ActiveRecord::Relation', @controller.send(:list_entities).class.name
      end

      it 'loads entities' do
        assert_equal 'ActiveRecord::Relation', @controller.send(:load_entities).class.name
      end
    end

    describe 'Fetching a single entity' do
      before do
        ::Temping.create :another_example do
          with_columns do |t|
            # t.integer :id # Causes: ActiveRecord::StatementInvalid: SQLite3::SQLException: duplicate column name: id
          end
        end

        @example = ::AnotherExample.create
        @controller = ::AnotherExamplesController.new
      end

      after do
        Temping.teardown # NOTE: Required cause global teardown for gem 'temping' does not work!!!
      end

      it 'loads a single entity for a given ID via method-argument' do
        @controller.send(:"params=", { action: 'new' })
        assert_equal 'AnotherExample', @controller.send(:load_entity, @example.id).class.name
      end

      it 'loads a single entity for a given ID via controller-params' do
        @controller.send(:"params=", { action: 'new', id: @example.id })
        assert_equal 'AnotherExample', @controller.send(:load_entity).class.name
      end
    end
  end
end
