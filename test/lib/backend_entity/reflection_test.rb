require 'test_helper'

module BackendEntity
  class ReflectionTest < ActiveSupport::TestCase
    class ::Example < ::ActiveRecord::Base; end # NOTE: This clashes with Temping!

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
    end

    class ::AnotherExamplesController < ::ActionController::Base
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
            assert_raises(BackendEntity::UnresolveableEntityType) do
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

      it 'provides the entity-id-key as a symbol' do
        assert_equal :example_id, @controller.send(:entity_id_key)
      end

      it 'provides a method for detecting entity-inheritation' do
        assert @controller.respond_to?(:entity_inherited?, true) # protected!
      end

      describe 'entity-inheritation' do
        before do
          ::Temping.create :another_example do
            with_columns do |t|
            end
          end

          ::Temping.create :inherited_example do
            with_columns do |t|
              t.string :type
            end
          end

          @another_controller = AnotherExamplesController.new
          @inherited_controller = InheritedExamplesController.new
        end

        after do
          Temping.teardown # NOTE: Required cause global teardown for gem 'temping' does not work!!!
        end

        it 'detects entity-inheritation' do
          refute @another_controller.send(:entity_inherited?)
        end

        it 'detects entity-inheritation when an entity is inherited' do
          assert @inherited_controller.send(:entity_inherited?)
        end
      end
    end
  end
end
