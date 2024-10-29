require 'test_helper'

module Backend
  class ExamplesControllerTest < ActionController::TestCase
    # NOTE: Automatic resolution of controller-class does not work in this TestCase ... Whyever! #4
    self.controller_class = Backend::ExamplesController

    describe 'Action #index' do
      setup do
        Example.create!
      end

      it 'succeeds on a request and renders view :index' do
        get :index

        assert_response :success
        assert_template 'backend/examples/index'
      end

      it 'loads entities' do
        get :index

        assert_equal Example.all, assigns(:entities)
      end
    end

    describe 'Action #show' do
      setup do
        @example = Example.create!
      end

      it 'succeeds on a request and renders view :show' do
        get :show, params: { id: @example.id }

        assert_response :success
        assert_template 'backend/examples/show'
      end

      it 'loads a single entity' do
        get :show, params: { id: @example.id }

        assert_equal @example, assigns(:entity)
      end

      it 'raises with default rails-behaviour if the id is not given in the request' do
        assert_raise(ActionController::UrlGenerationError) { get :show }
      end
    end

    describe 'Action #new' do
      it 'succeeds on a request and renders view :form' do
        get :new

        assert_response :success
        assert_template 'backend/examples/form'
      end

      it 'loads a new entity' do
        get :new

        assert_instance_of Example, assigns(:entity)
        assert assigns(:entity).new_record?
      end
    end

    describe 'Action #edit' do
      setup do
        @example = Example.create
      end

      it 'succeeds on a request and renders view :form' do
        get :edit, params: { id: @example.id }

        assert_response :success
        assert_template 'backend/examples/form'
      end

      it 'loads a single entity for editing' do
        get :edit, params: { id: @example.id }

        assert_equal @example, assigns(:entity)
      end
    end

    describe 'Action #create' do
      it 'succeeds on a request and renders view :index' do
        post :create, params: { example: { name: 'Example' } }

        # assert_redirected_to backend_example_path(assigns(:entity)) # NOTE: Default is here rendering :index
        assert_redirected_to backend_examples_path
      end

      it 'creates a new entity' do
        assert_difference('Example.count') do
          post :create, params: { example: { name: 'Example' } }
        end
      end
    end

    describe 'Action #update' do
      setup do
        @example = Example.create
      end

      it 'succeeds on a request and renders view :show' do
        patch :update, params: { id: @example.id, example: { name: 'UpdatedExampleName' } }

        assert_redirected_to backend_example_path(assigns(:entity))
      end

      it 'updates a single entity' do
        patch :update, params: { id: @example.id, example: { name: 'UpdatedExampleName' } }

        @example.reload
        assert_equal 'UpdatedExampleName', assigns(:entity).name
      end
    end

    describe 'Action #destroy' do
      setup do
        @example = Example.create
      end

      it 'succeeds on a request and renders view :index' do
        delete :destroy, params: { id: @example.id }

        assert_redirected_to backend_examples_path
      end

      it 'destroys a single entity' do
        assert_difference('Example.count', -1) do
          delete :destroy, params: { id: @example.id }
        end
      end
    end
  end
end
