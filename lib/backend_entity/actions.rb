module BackendEntity
  module Actions
    extend ActiveSupport::Concern

    class NonAllowedAction < StandardError; end

    attr_reader :entities, :entity

    #-------------------------------------------------------------------------------------------------------------------
    # Default CRUD-actions
    #-------------------------------------------------------------------------------------------------------------------

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

    # TODO: Method-arguments are powered by action_args-gem #4
    def create(custom_params = nil, error_msg = nil)
      @entity = entity_class.new(custom_params || entity_params) # TODO: Removed decorate-call for now #4 .decorate
      perform_create(error_msg)
    end

    # TODO: Method-arguments are powered by action_args-gem #4
    def update(custom_params = nil)
      if @entity.update(custom_params || entity_params)
        # @entity.action_flash(action_name, result: true) # TODO: action_flash needs to be migrated #4
        redirect_to_entity
      else
        # @entity.action_flash(action_name) # TODO: action_flash needs to be migrated #4
        render_form
      end
    end

    def destroy
      @entity.destroy
      # @entity.action_flash(action_name, result: @entity.destroy) # TODO: action_flash needs to be migrated #4
      redirect_to entity_index_path
    end

    #-------------------------------------------------------------------------------------------------------------------
    # CRUD-support-methods
    #-------------------------------------------------------------------------------------------------------------------

    protected def perform_create(_error_msg = nil)
      if @entity.save
        # @entity.action_flash(action_name, result: true) # TODO: action_flash needs to be migrated #4
        redirect_to action: :index
      else
        # @entity.action_flash(action_name, error_msg: error_msg) # TODO: action_flash needs to be migrated #4
        render_form
      end
    end

    protected def render_form
      render 'form'
    end

    # TODO: This method is not yet fully migrated #4
    protected def redirect_to_entity
      redirect_to entity_show_path
    end

    # TODO: Rework this concept! #3
    protected def restrict_action
      raise NonAllowedAction
    end
  end
end
