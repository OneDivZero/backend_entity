require 'test_helper'

module BackendEntity
  class ActionsTest < ActiveSupport::TestCase #ActionController::TestCase
    # class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Fetching
      include BackendEntity::Routes
      include BackendEntity::Actions

      # include ActionController::Helpers
    end

    # tests ::ExamplesController DNW #3

    describe 'Actions' do
      before do
        ::Temping.create :example do
          with_columns do |t|
            # t.integer :id # Causes: ActiveRecord::StatementInvalid: SQLite3::SQLException: duplicate column name: id
          end
        end

        @example = ::Example.create
        @controller = ::ExamplesController.new
      end

      after do
        Temping.teardown # NOTE: Required cause global teardown for gem 'temping' does not work!!!
      end

      it 'loads entities when calling #index' do
        # assert_equal Example::ActiveRecord_Relation, @controller.index.class
        # get :index
        # assert_response :success
        assert @controller.index
      end
    end
  end
end
