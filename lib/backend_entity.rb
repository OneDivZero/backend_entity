require_relative 'backend_entity/version'
require_relative 'backend_entity/access'

module BackendEntity
  class GenericError < StandardError; end

  def self.version
    BackendEntity::VERSION
  end
end
