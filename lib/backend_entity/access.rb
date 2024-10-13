module BackendEntity
  module Access
    extend ActiveSupport::Concern

    class UnknownEntityType < StandardError; end

    included do
      class_attribute :entity_model_name, :current_entity_name, :current_entity_class
      # class_attribute :entity_name, :entity_model, :entity_class #OPT!
    end

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
  end
end
