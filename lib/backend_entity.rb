require_relative 'backend_entity/version'

module BackendEntity
  class Error < StandardError; end

  def self.version
    BackendEntity::VERSION
  end
end
