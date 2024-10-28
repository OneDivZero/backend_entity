require 'test_helper'

module BackendEntity
  class ParametersTest < ActiveSupport::TestCase
    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Scopes
      include BackendEntity::Parameters
    end

    class ::AnotherExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Scopes
      include BackendEntity::Parameters
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

    describe 'Entity-ID-Resolving-Methods' do
      before do
        @controller = ::ExamplesController.new
      end

      it 'retrieves an ID for the entity from params' do
        id = 1
        @controller.send(:"params=", { id: id })
        assert_equal id, @controller.send(:entity_id_from_params)
      end

      it 'retrieves an ID for the entity from params when invoked with an alternative-key' do
        id = 2
        @controller.send(:"params=", { alternative_id: id })
        assert_equal id, @controller.send(:entity_id_from_params, :alternative_id)
      end

      it 'retrieves an ID for the entity from params when invoked with an alternative-key taking precedence over params[:idi]' do
        id = 2
        @controller.send(:"params=", { alternative_id: id, id: 3 })
        assert_equal id, @controller.send(:entity_id_from_params, :alternative_id)
      end

      it 'raises UnresolveableIdParameter if no strategy for retrieving an ID is applicable' do
        @controller.send(:"params=", {})
        assert_raises(BackendEntity::Parameters::UnresolveableIdParameter) { @controller.send(:entity_id_from_params) }
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

      it 'detects the type of an entity via :entity_type_from_params' do
        @controller.send(:"params=", { another_example: { type: 'AnotherExample' } })
        assert_equal 'AnotherExample', @controller.send(:entity_type_from_params)
      end

      it 'fails if the type of an entity is unknown via :entity_type_from_params' do
        @controller.send(:"params=", { another_example: { type: 'UnknownEntity' } })
        assert_raises(BackendEntity::UnknownEntityType) { @controller.send(:entity_type_from_params) }
      end

      it 'returns the class of an entity' do
        @controller.send(:"params=", { another_example: { type: 'AnotherExample' } })
        assert_equal AnotherExample, @controller.send(:entity_class_from_params)
      end
    end
  end
end
