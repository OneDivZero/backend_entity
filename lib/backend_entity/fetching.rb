module BackendEntity
  module Fetching
    include BackendEntity::Scopes
    include BackendEntity::Parameters

    # NOTE: This extra-step is required for handling overrides in entity-concerns!
    # e.g. when overriding :list_entities in a controller, module Backend::EntityFilterable will not work any more,
    # cause :list_entities is enhanced by this concern and we call super on it.
    protected def list_entities
      load_entities
    end

    protected def load_entities
      entity_has_backend_scope? ? entity_class.public_send(backend_entity_scope).all : entity_class.all
    end

    # NOTE: All models are decorated using Draper only for backend-purposes
    protected def load_entity(entity_id = nil)
      entity_id ||= entity_id_from_params unless new_action? # NOTE: This conditional is new!!! #4
      @entity = (new_action? ? entity_class.new : scoped_entity_class.find(entity_id))

      # TODO: We skip this for now ... requires module EntityPresentation #3
      # prepare_entity_for_view
    end

    # TODO: Check if required, as of yet only inside DIVE #3
    # protected def require_entity
    #   entity_scope = entity_has_backend_scope? ? entity_class.public_send(backend_entity_scope) : entity_class
    #   @entity = entity_scope.find(id_from_params)
    #   prepare_entity_for_view
    # end
  end
end
