require 'test_helper'

class DevTest < ActiveSupport::TestCase
  describe 'Development' do
    it 'tells the RUBY_VERSION via ENV' do
      if ENV['RUBY_VERSION']
        puts "[NOTE] RUBY_VERSION is defined as #{ENV["RUBY_VERSION"]}".colorize(:green)
      else
        puts '[NOTE] RUBY_VERSION is not defined via ENV'.colorize(:yellow)
      end
    end

    it 'tells the RAILS_VERSION via ENV' do
      if ENV['RAILS_VERSION']
        puts "[NOTE] RAILS_VERSION is defined as #{ENV["RAILS_VERSION"]}".colorize(:green)
      else
        puts '[NOTE] RAILS_VERSION is not defined via ENV'.colorize(:yellow)
      end
    end
  end
end
