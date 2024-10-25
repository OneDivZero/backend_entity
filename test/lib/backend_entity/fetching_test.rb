require 'test_helper'

module BackendEntity
  class FetchingTest < ActiveSupport::TestCase
    # class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Fetching
    end

    describe 'Fetching entities' do
      before do
        @controller = ExamplesController.new
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
        ::Temping.create :example do
          with_columns do |t|
            # t.integer :id # Causes: ActiveRecord::StatementInvalid: SQLite3::SQLException: duplicate column name: id
          end
        end

        @example = Example.create
        @controller = ExamplesController.new
      end

      it 'loads a single entity' do
        assert_equal 'Example', @controller.send(:load_entity, @example.id).class.name
      end
    end
  end
end
