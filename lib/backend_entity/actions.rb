module BackendEntity
  module Actions
    extend ActiveSupport::Concern

    class NonAllowedAction < StandardError; end

    attr_reader :entities, :entity

    def index
      @entities = list_entities
    end

    def show; end

    def new
      render_form
    end

    def edit
      render_form
    end

    protected def render_form
      render 'form'
    end

    # TODO: Rework this concept! #3
    protected def restrict_action
      raise NonAllowedAction
    end
  end
end
