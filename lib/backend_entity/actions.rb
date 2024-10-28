module BackendEntity
  module Actions
    extend ActiveSupport::Concern

    attr_reader :entities, :entity

    def index
      @entities = list_entities
    end
  end
end
