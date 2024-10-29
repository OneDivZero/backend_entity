require 'test_helper'

module Backend
  class ExamplesControllerTest < ActionController::TestCase
    # NOTE: Automatic resolution of controller-class does not work!
    self.controller_class = ::Backend::ExamplesController

    describe 'Action #index' do
      setup do
        @example = ::Example.create
      end

      it 'loads entities' do
        get :index

        assert_response :success
        assert_equal Example.all, assigns(:entities)
        assert_template 'backend/examples/index'
      end
    end

    describe 'Action #show' do
      setup do
        @example = ::Example.create
      end

      it 'loads a single entity' do
        get :show, params: { id: @example.id }

        assert_response :success
        assert_equal @example, assigns(:entity)
        assert_template 'backend/examples/show'
      end
    end

    describe 'Action #new' do
      it 'loads a new entity' do
        get :new

        assert_response :success
        assert_instance_of Example, assigns(:entity)
        assert assigns(:entity).new_record?
        assert_template 'backend/examples/form'
      end
    end

    describe 'Action #edit' do
      setup do
        @example = ::Example.create
      end

      it 'loads a single entity for editing' do
        get :edit, params: { id: @example.id }

        assert_response :success
        assert_equal @example, assigns(:entity)
        assert_template 'backend/examples/form'
      end
    end

    describe 'Action #create' do
      it 'creates a new entity' do
        assert_difference('Example.count') do
          post :create, params: { example: { name: 'Example' } }
        end

        # assert_redirected_to backend_example_path(assigns(:entity)) # NOTE: Default is here rendering :index
        assert_redirected_to backend_examples_path
      end
    end

    describe 'Action #update' do
      setup do
        @example = ::Example.create
      end

      it 'updates a single entity' do
        patch :update, params: { id: @example.id, example: { name: 'NewExampleName' } }

        assert_redirected_to backend_example_path(assigns(:entity))
      end
    end

    describe 'Action #destroy' do
      setup do
        @example = ::Example.create
      end

      it 'destroys a single entity' do
        assert_difference('Example.count', -1) do
          delete :destroy, params: { id: @example.id }
        end

        assert_redirected_to backend_examples_path
      end
    end
  end
end
