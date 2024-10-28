module BackendEntity
  module Scopes
    extend ActiveSupport::Concern
    # NOTE: Fully migrated but not yet tested!

    protected def backend_entity_scope
      :backend
    end

    protected def entity_has_backend_scope?
      entity_class.respond_to?(backend_entity_scope)
    end

    protected def scoped_entity_class
      entity_has_backend_scope? ? entity_class.public_send(backend_entity_scope) : entity_class
    end

    protected def allowed_scopes
      []
    end

    protected def check_allowed_scopes!
      return if params[:entity_scope].nil?

      raise BackendEntity::UnknownEntityScope unless allowed_scopes.include?(params[:entity_scope].to_sym)
    end
  end
end
