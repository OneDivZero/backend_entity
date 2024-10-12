require 'test_helper'

class TestBackendEntity < Minitest::Test
  describe 'Gem' do
    it 'test_that_it_has_a_version_number' do
      refute_nil ::BackendEntity::VERSION
    end
  end

  def test_it_does_something_useful
    assert true
  end
end
