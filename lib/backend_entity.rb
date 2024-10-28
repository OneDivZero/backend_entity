require_relative 'backend_entity/version'
require_relative 'backend_entity/reflection'
require_relative 'backend_entity/scopes'
require_relative 'backend_entity/parameters'
require_relative 'backend_entity/fetching'
require_relative 'backend_entity/routes'
require_relative 'backend_entity/actions'
require_relative 'backend_entity/controller'

module BackendEntity
  class GenericError < StandardError; end
  class UnresolveableEntityType < StandardError; end
  class UnknownEntityType < StandardError; end
  class UnknownEntityScope < StandardError; end

  def self.version
    BackendEntity::VERSION
  end
end
