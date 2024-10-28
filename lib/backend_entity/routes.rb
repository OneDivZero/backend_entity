module BackendEntity
  module Routes
    extend ActiveSupport::Concern

    PREFIX = 'backend'.freeze

    included do
    end

    def entity_index_path(params: {})
      public_send(entity_index_path_name, params)
    end

    def entity_show_path(entity = nil, params: {})
      entity ||= @entity
      public_send(entity_show_path_name, entity, params)
    end

    def entity_create_path(entity = nil, params: {})
      entity ||= @entity
      public_send(entity_create_path_name, entity, params)
    end

    def entity_update_path(entity = nil, params: {})
      entity ||= @entity
      public_send(entity_update_path_name, entity, params)
    end

    def entity_destroy_path(entity = nil, params: {})
      entity ||= @entity
      public_send(entity_destroy_path_name, entity, params)
    end

    def entity_new_path(entity = nil, params: {})
      entity ||= @entity
      public_send(entity_new_path_name, entity, params)
    end

    def entity_edit_path(entity = nil, params: {})
      entity ||= @entity
      public_send(entity_edit_path_name, entity, params)
    end

    def entity_list_path
      public_send(entity_list_path_name)
    end

    def entity_search_path
      public_send(entity_search_path_name)
    end

    protected def entity_route_key
      (@entity || entity_class).model_name.singular_route_key
    end

    private def entity_index_path_name
      "#{PREFIX}_#{entity_route_key.pluralize}_path".to_sym
    end

    private def entity_show_path_name
      "#{PREFIX}_#{entity_route_key}_path".to_sym
    end

    private def entity_create_path_name
      entity_show_path_name
    end

    private def entity_update_path_name
      entity_show_path_name
    end

    private def entity_destroy_path_name
      entity_show_path_name
    end

    private def entity_new_path_name
      "new_#{PREFIX}_#{entity_route_key}_path".to_sym
    end

    private def entity_edit_path_name
      "edit_#{PREFIX}_#{entity_route_key}_path".to_sym
    end

    private def entity_list_path_name
      "list_#{PREFIX}_#{entity_route_key.pluralize}_path".to_sym
    end

    private def entity_search_path_name
      "search_#{PREFIX}_#{entity_route_key.pluralize}_path".to_sym
    end
  end
end
