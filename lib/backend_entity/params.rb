module BackendEntity
  module Params
    extend ActiveSupport::Concern

    class UnresolveableIdParameter < StandardError; end

    protected def new_action?
      params[:action].eql?('new')
    end

    protected def edit_action?
      params[:action].eql?('edit')
    end

    # Resolves an id from params for a given alternative-key or id-key
    # or a key based on entitiy-name ending with suffix '_id'
    protected def id_from_params(alternative_id_key = nil)
      params[alternative_id_key&.to_sym] || params[:id] || params[entity_id_key] || raise(UnresolveableIdParameter)
    end

    # protected def entity_params
    #   params.require(entity_name.underscore.to_sym).permit(*entity_class.column_names)
    # end
  end
end
