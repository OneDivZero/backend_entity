require_relative 'backend_entity/version'

module BackendEntity
  class GenericError < StandardError; end

  def self.version
    BackendEntity::VERSION
  end
end
