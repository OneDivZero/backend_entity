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
      end
    end
  end
end
