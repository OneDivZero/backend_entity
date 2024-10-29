module BackendEntity
  module Routes
    extend ActiveSupport::Concern

    PREFIX = 'backend'.freeze

    included do
      alias_method :entity_path, :entity_show_path
      alias_method :entity_path_name, :entity_show_path_name

      entity_path_methods = %w[index show new create edit update destroy list search].map do |action_name|
        "entity_#{action_name}_path".to_sym
      end

      helper_method(*entity_path_methods)
      helper_method(:entity_path)
    end

    def entity_index_path(params: {})
      public_send(entity_index_path_name, params)
    end

    %w[show create update destroy new edit].each do |action_name|
      define_method("entity_#{action_name}_path") do |entity = nil, params: {}|
        entity ||= @entity
        path = send("entity_#{action_name}_path_name").to_sym
        public_send(path, entity, params)
      end
    end

    def entity_list_path(params: {})
      public_send(entity_list_path_name, params)
    end

    def entity_search_path(params: {})
      public_send(entity_search_path_name, params)
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
      entity_path_name
    end

    private def entity_update_path_name
      entity_path_name
    end

    private def entity_destroy_path_name
      entity_path_name
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
