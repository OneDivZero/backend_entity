require 'test_helper'

class BackendEntityTestAppTest < ActiveSupport::TestCase
  describe 'Routes' do
    before do
      @rails_routing_keys = Rails.application.routes.named_routes.send(:routes).keys
    end

    it 'has routes defined for the model named "Example" inside the BackendEntityTestApp' do
      assert_includes @rails_routing_keys, :examples
      assert_includes @rails_routing_keys, :example
      assert_includes @rails_routing_keys, :new_example
      assert_includes @rails_routing_keys, :edit_example
    end
  end
end
