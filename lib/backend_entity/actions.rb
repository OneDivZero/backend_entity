module BackendEntity
  module Actions
    extend ActiveSupport::Concern

    class NonAllowedAction < StandardError; end

    attr_reader :entities, :entity

    def index
      @entities = list_entities
    end

    # TODO: Rework this concept! #3
    protected def restrict_action
      raise NonAllowedAction
    end
  end
end
