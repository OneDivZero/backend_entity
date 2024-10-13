require 'test_helper'

module BackendEntity
  class InvocationTest < ActiveSupport::TestCase #Minitest::Test
    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Invocation
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
    end
  end
end
