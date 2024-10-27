module BackendEntity
  module Routes
    extend ActiveSupport::Concern

    included do
    end

    def entity_index_path(params: {})
      public_send("backend_#{entity_route_key.pluralize}_path".to_sym, params)
    end

    def entity_show_path(entity = nil, params: {})
      entity ||= @entity
      public_send("backend_#{entity_route_key}_path", entity, params)
    end

    def entity_new_path(entity = nil, params: {})
      entity ||= @entity
      public_send("new_backend_#{entity_route_key}_path".to_sym, entity, params)
    end

    def entity_create_path(entity = nil, params: {})
      entity ||= @entity
      entity_show_path(entity, params: params)
    end

    def entity_edit_path(entity = nil, params: {})
      entity ||= @entity
      public_send("edit_backend_#{entity_route_key}_path".to_sym, entity, params)
    end

    def entity_update_path(entity = nil, params: {})
      entity ||= @entity
      entity_show_path(entity, params: params)
    end

    def entity_destroy_path(entity = nil, params: {})
      entity ||= @entity
      entity_show_path(entity, params: params)
    end

    protected def entity_route_key
      (@entity || current_entity_class).model_name.singular_route_key
    end
  end
end
