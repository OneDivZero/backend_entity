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
  end
end
