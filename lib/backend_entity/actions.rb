module BackendEntity
  module Actions
    extend ActiveSupport::Concern

    include BackendEntity::Flashes

    class NonAllowedAction < StandardError; end

    attr_reader :entities, :entity

    included do
      rescue_from ActionController::UrlGenerationError, with: :handle_url_generation_error!
      rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
    end

    #-------------------------------------------------------------------------------------------------------------------
    # Default CRUD-actions
    #-------------------------------------------------------------------------------------------------------------------

    def index
      @entities = list_entities
    end

    def show; end

    def new; render_form end

    def edit; render_form end

    # TODO: Method-arguments are powered by action_args-gem #4
    def create(custom_params = nil, error_msg = nil)
      @entity = entity_class.new(custom_params || entity_params) # TODO: Removed decorate-call for now #4 .decorate
      perform_create(error_msg)
    end

    # TODO: Method-arguments are powered by action_args-gem #4
    def update(custom_params = nil)
      if @entity.update(custom_params || entity_params)
        # @entity.action_flash(action_name, result: true) # TODO: action_flash needs to be migrated #4
        entity_flash_message_for(action_name, on: @entity, result: true)
        redirect_to_entity
      else
        # @entity.action_flash(action_name) # TODO: action_flash needs to be migrated #4
        render_form
      end
    end

    def destroy
      @entity.destroy
      # @entity.action_flash(action_name, result: @entity.destroy) # TODO: action_flash needs to be migrated #4
      entity_flash_message_for(action_name, on: @entity, result: @entity.destroyed?)
      redirect_to entity_index_path
    end

    #-------------------------------------------------------------------------------------------------------------------
    # CRUD-support-methods
    #-------------------------------------------------------------------------------------------------------------------

    protected def perform_create(error_msg = nil)
      if @entity.save
        # @entity.action_flash(action_name, result: true) # TODO: action_flash needs to be migrated #4
        entity_flash_message_for(action_name, on: @entity, result: true)
        redirect_to(action: :index)
      else
        # @entity.action_flash(action_name, error_msg: error_msg) # TODO: action_flash needs to be migrated #4
        entity_flash_message_for(action_name, on: @entity, result: false, error: error_msg)
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

    #-------------------------------------------------------------------------------------------------------------------
    # Other methods
    #-------------------------------------------------------------------------------------------------------------------

    private def handle_url_generation_error!(error)
      puts '[WARNING] URL-Generation-Error: Maybe check your routing-method!'.colorize(:yellow)
      raise error
    end

    private def handle_record_not_found!(error)
      puts '[WARNING] Record-Not-Found-Error: Maybe check your routing-method!'.colorize(:yellow)
      raise error
    end
  end
end
