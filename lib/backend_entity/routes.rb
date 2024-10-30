# TODO: Deprecate all *_path methods in favour of *_route in a future major version methods #4
module BackendEntity
  module Routes
    extend ActiveSupport::Concern

    include BackendEntity::Pathes

    ALL_PATH_METHODS = %w[index show create update destroy new edit list search].freeze
    ENTITY_CRUD_ACTIONS = %w[show create update destroy new edit].freeze

    included do
      alias_method :entity_path, :entity_show_path

      entity_view_helper_path_methods = ALL_PATH_METHODS.map do |action_name|
        "entity_#{action_name}_path".to_sym
      end

      helper_method(*entity_view_helper_path_methods)
      helper_method(:entity_path)
    end

    def entity_index_path(params: {})
      public_send(entity_index_path_name, params)
    end

    def entity_list_path(params: {})
      public_send(entity_list_path_name, params)
    end

    def entity_search_path(params: {})
      public_send(entity_search_path_name, params)
    end

    ENTITY_CRUD_ACTIONS.each do |action_name|
      define_method("entity_#{action_name}_path") do |entity = nil, params: {}|
        entity ||= @entity
        path = send("entity_#{action_name}_path_name").to_sym
        public_send(path, entity, params)
      end
    end
  end
end
