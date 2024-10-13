module BackendEntity
  module Access
    extend ActiveSupport::Concern

    include BackendEntity::Scopes

    class UnknownEntityType < StandardError; end

    included do
      class_attribute :entity_model_name, :current_entity_name, :current_entity_class
      # class_attribute :entity_name, :entity_model, :entity_class #OPT! #3
    end

    # Class-methods for detecting the desired entity
    module ClassMethods
      def controller_class_name
        "#{controller_path.classify.pluralize}Controller"
      end

      def controller_class
        controller_class_name.constantize
      end

      def derive_entity_name
        inferred_entity_name = controller_class.entity_model_name.presence || controller_name.classify.demodulize

        raise UnknownEntityType unless const_defined?(inferred_entity_name)

        inferred_entity_name
      end

      def entity_name
        self.current_entity_name = derive_entity_name
      end

      def entity_class
        self.current_entity_class = entity_name.is_a?(Class) ? entity_name : entity_name.constantize
      end
    end

    protected def entity_name
      @current_entity_name = self.class.entity_name
    end

    protected def entity_class
      @current_entity_class = self.class.entity_class
    end

    protected def entity_key
      entity_name.underscore.to_sym
    end

    protected def entity_id_key
      entity_name.underscore.concat('_id').to_sym
    end

    protected def entity_inherited?
      entity_class.column_names.include?('type')
    end

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
    protected def load_entity(id = nil)
      id ||= id_from_params
      @entity = (new_action? ? entity_class.new : scoped_entity_class.find(id))

      # TODO: We skip this for now ... requires module EntityPresentation #3
      # prepare_entity_for_view
    end

    # TODO: Check if required, as of yet only inside DIVE #3
    # protected def require_entity
    #   entity_scope = entity_has_backend_scope? ? entity_class.public_send(backend_entity_scope) : entity_class
    #   @entity = entity_scope.find(id_from_params)
    #   prepare_entity_for_view
    # end

    # TODO: Rework this concept! #3
    protected def restrict_action
      raise NonAllowedAction
    end
  end
end
