require 'test_helper'

module BackendEntity
  class ReflectionTest < ActiveSupport::TestCase
    class ::Example < ::ActiveRecord::Base; end

    class ::ExamplesController < ::ActionController::Base
      include BackendEntity::Reflection
      include BackendEntity::Fetching
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
