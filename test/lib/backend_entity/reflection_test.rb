require 'test_helper'

module BackendEntity
  class ReflectionTest < ActiveSupport::TestCase
    class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
    end

    class ::InheritedExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
    end

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
            assert_raises(BackendEntity::Reflection::UnknownEntityType) do
              ExamplesController.derive_entity_name
            end
          end
        end
      end
    end

    describe 'Entity-Instance-Methods' do
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

      describe 'entity-inheritation' do
        before do
          ::Temping.create :inherited_example do
            with_columns do |t|
              t.string :type
            end
          end

          @controller = InheritedExamplesController.new
        end

        it 'provides a method for detecting entity-inheritation' do
          assert @controller.send(:entity_inherited?)
        end
      end
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
  end
end
