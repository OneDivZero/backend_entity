require 'test_helper'

class BackendEntityTest < Minitest::Test
  describe 'Gem' do
    it 'it has a version-number' do
      assert ::BackendEntity::VERSION
    end

    it 'it has a fixed version-number (REMINDER)' do
      assert_equal '0.1.0', ::BackendEntity::VERSION
    end

    it 'provides a generic error-class' do
      assert Object.const_defined?('BackendEntity::GenericError')
    end
  end
end
