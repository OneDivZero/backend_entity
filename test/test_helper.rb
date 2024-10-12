$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

#-----------------------------------------------------------------------------------------------------------------------
# Common Test-Config
#-----------------------------------------------------------------------------------------------------------------------

require 'pry'
require 'pry-alias'
require 'rails'
require 'rails/test_help'
require 'minitest/autorun'

require 'backend_entity'

#-----------------------------------------------------------------------------------------------------------------------

#-----------------------------------------------------------------------------------------------------------------------
# Test-Support-Config
#-----------------------------------------------------------------------------------------------------------------------

# TODO: undefined method `join' for nil:NilClass (NoMethodError) #1
# %w[support helpers].each do |folder|
#   Dir[Rails.root.join('test', folder, '**', '*.rb')].sort.each { |f| require f }
# end

#-----------------------------------------------------------------------------------------------------------------------
# TestCase-Config
#-----------------------------------------------------------------------------------------------------------------------

# NOTE: This allows to use modules for shared tests!
class Module
  include Minitest::Spec::DSL if Rails.env.test?
end

#-----------------------------------------------------------------------------------------------------------------------
