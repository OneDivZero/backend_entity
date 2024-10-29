#-----------------------------------------------------------------------------------------------------------------------
# Common Test-Config
#-----------------------------------------------------------------------------------------------------------------------

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require './test/requirements'
require 'backend_entity'
require 'backend_entity_test_app/backend_entity_test_app'

#-----------------------------------------------------------------------------------------------------------------------
# Test-Support-Config
#-----------------------------------------------------------------------------------------------------------------------

# TODO: undefined method `join' for nil:NilClass (NoMethodError) #1
# %w[support helpers].each do |folder|
#   Dir[Rails.root.join('test', folder, '**', '*.rb')].sort.each { |f| require f }
# end

#-----------------------------------------------------------------------------------------------------------------------
# Test-Reporting-Config
#-----------------------------------------------------------------------------------------------------------------------
require './test/support/config/reporting'

#-----------------------------------------------------------------------------------------------------------------------
# Database-Config
#-----------------------------------------------------------------------------------------------------------------------

require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

CreateAllTables.up unless ActiveRecord::Base.connection.table_exists?('examples')

#-----------------------------------------------------------------------------------------------------------------------
# TestCase-Config
#-----------------------------------------------------------------------------------------------------------------------

module ActiveSupport
  class TestCase
    # TODO: #teardown never get's invoked during the tests #3
    teardown do
      puts 'ActiveSupport::TestCase.teardown'.colorize(:green)
      # raise 'ActiveSupport::TestCase.teardown'
      Temping.teardown # Required global teardown for gem 'temping'
    end
  end
end

# NOTE: This allows to use modules for shared tests!
class Module
  include Minitest::Spec::DSL if Rails.env.test?
end

#-----------------------------------------------------------------------------------------------------------------------
