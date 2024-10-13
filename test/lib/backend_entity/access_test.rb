require 'test_helper'

require 'active_record'

module BackendEntity
  # Minitest::Test
  class AccessTest < ActiveSupport::TestCase
    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Access
    end

    class ::Example < ::ActiveRecord::Base; end

    describe 'Concern' do
      it 'provides accessors for the metadata of an entity' do
        assert ExamplesController.respond_to?(:entity_model_name)
        assert ExamplesController.respond_to?(:current_entity_name)
        assert ExamplesController.respond_to?(:current_entity_class)
      end

      it 'provides class-methods for the controller-class' do
        assert ExamplesController.respond_to?(:controller_class_name)
        assert ExamplesController.respond_to?(:controller_class)

        assert_equal 'ExamplesController', ExamplesController.controller_class_name
        assert_equal ExamplesController.name, ExamplesController.controller_class.name
      end

      it 'can derive the entity-name' do
        assert_equal 'Example', ExamplesController.derive_entity_name
      end

      it 'sets :current_entity_name when calling :entity_name' do
        ExamplesController.entity_name
        assert_equal 'Example', ExamplesController.current_entity_name
      end

      it 'sets :current_entity_class when calling :entity_class' do
        ExamplesController.entity_class
        assert_equal Example, ExamplesController.current_entity_class
      end

      describe 'Error' do
        it 'raises an error for an unknown entity-type' do
          ExamplesController.stub(:controller_name, 'UnknownController') do
            assert_raises(BackendEntity::Access::UnknownEntityType) do
              ExamplesController.derive_entity_name
            end
          end
        end
      end
    end

    describe 'Instance' do
      before do
        @controller = ExamplesController.new
      end

      it 'provides the entity-name' do
        assert_equal 'Example', @controller.send(:entity_name)
      end

      it 'provides the entity-class' do
        assert_equal Example, @controller.send(:entity_class)
      end

      it 'provides the entity-key' do
        assert_equal :example, @controller.send(:entity_key)
      end

      it 'provides the entity-id-key as a symbole' do
        assert_equal :example_id, @controller.send(:entity_id_key)
      end
    end
  end
end
