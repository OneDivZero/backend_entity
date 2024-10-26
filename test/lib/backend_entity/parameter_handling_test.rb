require 'test_helper'

module BackendEntity
  class ParameterHandlingTest < ActiveSupport::TestCase
    class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Scopes
      include BackendEntity::ParameterHandling
    end

    class ::AnotherExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Scopes
      include BackendEntity::ParameterHandling
    end

    describe 'Action-Support-Methods' do
      before do
        @controller = ::ExamplesController.new
      end

      it 'provides a method for detecting action-type :new' do
        @controller.send(:"params=", { action: 'new' })
        assert @controller.send(:new_action?)
      end

      it 'provides a method for detecting action-type :edit' do
        @controller.send(:"params=", { action: 'edit' })
        assert @controller.send(:edit_action?)
      end
    end

    describe 'ID-Resolving-Methods' do
      before do
        @controller = ::ExamplesController.new
      end

      it 'retrieves an ID from params' do
        id = 1
        @controller.send(:"params=", { id: id })
        assert_equal id, @controller.send(:id_from_params)
      end

      it 'retrieves an ID from params when invoked with an alternative-key' do
        id = 2
        @controller.send(:"params=", { alternative_id: id })
        assert_equal id, @controller.send(:id_from_params, :alternative_id)
      end

      it 'retrieves an ID from params when invoked with an alternative-key taking precedence over params[:idi]' do
        id = 2
        @controller.send(:"params=", { alternative_id: id, id: 3 })
        assert_equal id, @controller.send(:id_from_params, :alternative_id)
      end

      it 'raises UnresolveableIdParameter if no strategy for retrieving an ID is applicable' do
        @controller.send(:"params=", {})
        assert_raises(BackendEntity::ParameterHandling::UnresolveableIdParameter) { @controller.send(:id_from_params) }
      end
    end

    describe 'Entity-Parameter-Methods' do
      before do
        ::Temping.create :another_example do
          with_columns do |t|
            # t.integer :id # Causes: ActiveRecord::StatementInvalid: SQLite3::SQLException: duplicate column name: id
          end
        end

        # @example = ::AnotherExample.create
        @controller = ::AnotherExamplesController.new
      end

      after do
        Temping.teardown # NOTE: Required cause global teardown for gem 'temping' does not work!!!
      end

      it 'retrieves entity-params from controller-params' do
        @controller.send(:"params=", { another_example: { name: 'Example' } })
        # @controller.send(:"params=", { another_example: { } })
        # @controller.send(:"params=", { another_example: nil })

        assert_equal ActionController::Parameters, @controller.send(:entity_params).class
        # TODO: Why they are permitted when using { another_example: { name: 'Example' } } ??? #3
        assert @controller.send(:entity_params).permitted?
      end
    end
  end
end
