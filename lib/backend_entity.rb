require_relative 'backend_entity/version'
require_relative 'backend_entity/scopes'
require_relative 'backend_entity/reflection'

module BackendEntity
  class GenericError < StandardError; end

  def self.version
    BackendEntity::VERSION
  end
end
