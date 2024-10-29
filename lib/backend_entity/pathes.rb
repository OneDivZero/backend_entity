module BackendEntity
  module Pathes
    extend ActiveSupport::Concern

    PREFIX = 'backend'.freeze

    included do
      alias_method :entity_path_name, :entity_show_path_name
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
