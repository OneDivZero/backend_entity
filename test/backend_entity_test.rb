require 'test_helper'

# Minitest::Test
class BackendEntityTest < ActiveSupport::TestCase
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

    it 'provides an error-class for unresolveable types' do
      assert Object.const_defined?('BackendEntity::UnresolveableEntityType')
    end

    it 'provides an error-class for unknown scope' do
      assert Object.const_defined?('BackendEntity::UnknownEntityScope')
    end
  end
end
