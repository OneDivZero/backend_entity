require 'test_helper'

class BackendEntityTest < Minitest::Test
  describe 'Gem' do
    it 'has a version-number' do
      assert ::BackendEntity::VERSION
    end

    it 'has a fixed version-number (REMINDER)' do
      puts "Current version #{::BackendEntity::VERSION}".colorize(:blue)
      assert_equal '0.1.0', ::BackendEntity::VERSION
    end

    it 'provides a generic error-class' do
      assert Object.const_defined?('BackendEntity::GenericError')
    end
  end
end
