require 'test_helper'

module BackendEntity
  class RoutesTest < ActiveSupport::TestCase
    class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Fetching
      include BackendEntity::Routes
    end

    # TODO: Why can't I access this method from the test? #3
    # def rails_routing_keys
    #   Rails.application.routes.named_routes.send(:routes).keys
    # end

    describe 'Routes' do
      before do
        @rails_routing_keys = Rails.application.routes.named_routes.send(:routes).keys
        @controller = ::ExamplesController.new
      end

      it 'has routes defined for the BackendEntityTestApp' do
        # @controller.public_send(:examples_path) # NoMethodError: undefined method `host' for nil:NilClass (on rails-request-object)
        assert_includes @rails_routing_keys, :examples
        assert_includes @rails_routing_keys, :example
        assert_includes @rails_routing_keys, :new_example
        assert_includes @rails_routing_keys, :edit_example
      end

      it 'has generic entity-routes for all common actions' do
        assert @controller.respond_to?(:entity_index_path)
        assert @controller.respond_to?(:entity_show_path)
        assert @controller.respond_to?(:entity_new_path)
        assert @controller.respond_to?(:entity_create_path)
        assert @controller.respond_to?(:entity_edit_path)
        assert @controller.respond_to?(:entity_update_path)
        assert @controller.respond_to?(:entity_destroy_path)
      end
    end
  end
end
