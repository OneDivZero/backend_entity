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

    describe 'Concern' do
      before do
        @rails_routing_keys = Rails.application.routes.named_routes.send(:routes).keys
        @controller = ::ExamplesController.new
      end

      it 'detects the routing-key from the entity' do
        assert_equal 'example', @controller.send(:entity_route_key)
      end

      it 'has generic entity-routes for all common actions' do
        assert @controller.respond_to?(:entity_index_path)
        assert @controller.respond_to?(:entity_show_path)
        assert @controller.respond_to?(:entity_create_path)
        assert @controller.respond_to?(:entity_update_path)
        assert @controller.respond_to?(:entity_destroy_path)
        assert @controller.respond_to?(:entity_new_path)
        assert @controller.respond_to?(:entity_edit_path)
      end

      it 'has additional entity-routes for action :list and :search' do
        assert @controller.respond_to?(:entity_list_path)
        assert @controller.respond_to?(:entity_search_path)
      end

      it 'has generic entity-route-name-methods for all common actions' do
        # @controller.public_send(:examples_path) # NoMethodError: undefined method `host' for nil:NilClass (on rails-request-object)
        assert_equal :backend_examples_path, @controller.send(:entity_index_path_name)
        assert_equal :backend_example_path, @controller.send(:entity_show_path_name)
        assert_equal :backend_example_path, @controller.send(:entity_create_path_name)
        assert_equal :backend_example_path, @controller.send(:entity_update_path_name)
        assert_equal :backend_example_path, @controller.send(:entity_destroy_path_name)
        assert_equal :new_backend_example_path, @controller.send(:entity_new_path_name)
        assert_equal :edit_backend_example_path, @controller.send(:entity_edit_path_name)
      end

      it 'has additional entity-route-name-methods for action :list and :search' do
        assert_equal :list_backend_examples_path, @controller.send(:entity_list_path_name)
        assert_equal :search_backend_examples_path, @controller.send(:entity_search_path_name)
      end
    end
  end
end
