module BackendEntity
  module ParameterHandling
    extend ActiveSupport::Concern
    # NOTE: Fully migrated and well tested!

    class UnresolveableIdParameter < StandardError; end

    # TODO: Is this the right place for this method? #4
    protected def new_action?
      params[:action].eql?('new')
    end

    # TODO: Is this the right place for this method? #4
    protected def edit_action?
      params[:action].eql?('edit')
    end

    # Resolves an id from params for a given alternative-key or common id-key
    # or a key based on entitiy-name ending with suffix '_id'
    protected def entity_id_from_params(alternative_id_key = nil)
      params[alternative_id_key&.to_sym] || params[:id] || params[entity_id_key] || raise(UnresolveableIdParameter)
    end

    # Permit the controller-params for an entiity using the derived entity_key.
    # Could be parameterized (this is new!) or overridden inside any controller.
    # When nothing is specified, then all columns of the entity-class will be permitted!
    # IMPROVE: Maybe a special declaratioon-method is a better way for doing this job #3
    protected def entity_params(using: [])
      # TODO: Use a logger instead! #3
      puts '[WARNING] #entity_params is using all entity-columns in your controller!'.colorize(:yellow) if using.blank?

      allowed = using.blank? ? entity_column_names : using

      params.require(entity_key).permit(*allowed)
    end

    # Required for detecting STI-Subtypes if the entity-key is a generic one
    protected def entity_type_from_params
      type = params[entity_key]&.dig(:type)

      raise BackendEntity::UnknownEntityType unless known_entity?(type)

      type
    end

    protected def entity_class_from_params
      class_name = entity_type_from_params
      class_name.constantize if class_name.present?
    end
  end
end
