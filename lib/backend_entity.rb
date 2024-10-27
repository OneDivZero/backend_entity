require_relative 'backend_entity/version'
require_relative 'backend_entity/reflection'
require_relative 'backend_entity/scopes'
require_relative 'backend_entity/parameter_handling'
require_relative 'backend_entity/fetching'

module BackendEntity
  class GenericError < StandardError; end
  class UnresolveableEntityType < StandardError; end
  class UnknownEntityType < StandardError; end
  class UnknownEntityScope < StandardError; end

  def self.version
    BackendEntity::VERSION
  end
end
