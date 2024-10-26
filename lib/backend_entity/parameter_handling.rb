module BackendEntity
  module ParameterHandling
    extend ActiveSupport::Concern

    class UnresolveableIdParameter < StandardError; end

    protected def new_action?
      params[:action].eql?('new')
    end

    protected def edit_action?
      params[:action].eql?('edit')
    end

    # Resolves an id from params for a given alternative-key or common id-key
    # or a key based on entitiy-name ending with suffix '_id'
    protected def id_from_params(alternative_id_key = nil)
      params[alternative_id_key&.to_sym] || params[:id] || params[entity_id_key] || raise(UnresolveableIdParameter)
    end

    # Permit the controller-params for an entiity using the derived entity_key.
    # Could be parameterized (this is new!) or overridden inside any controller.
    # When nothing is specified, then all columns of the entity-class will be permitted!
    # IMPROVE: Maybe a special declaratioon-method is a better way for doing this job #3
    protected def entity_params(using: [])
      # TODO: Use a logger instead! #3
      puts '[WARNING] #entity_params is using all entity-columns in your controller!'.colorize(:yellow) if using.blank?

      allowed = using.blank? ? entity_class.column_names : using

      params.require(entity_key).permit(*allowed)
    end
  end
end
