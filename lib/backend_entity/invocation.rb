module BackendEntity
  module Invocation
    extend ActiveSupport::Concern

    included do
      class_attribute :entity_model_name, :current_entity_name, :current_entity_class
      # class_attribute :entity_name, :entity_model, :entity_class
    end

    module ClassMethods
      def controller_class_name
        "#{controller_path.classify.pluralize}Controller"
      end

      def controller_class
        controller_class_name.constantize
      end
    end

    # class << self
    #   def included(base)
    #     base.extend(ClassMethods)
    #   end
    # end

    # module ClassMethods
    #   def access(*args)
    #     options = args.extract_options!
    #     options[:only] = args
    #     options[:except] = [] if options[:only].present?
    #     options[:except] = args if options[:only].blank?

    #     before_action(options) do
    #       access = Access.new(self)
    #       access.check_permissions
    #     end
    #   end
    # end

    # def initialize(controller)
    #   @controller = controller
    # end

    # def check_permissions
    #   return if @controller.current_user&.admin?

    #   if @controller.action_name.in?(options[:except])
    #     raise BackendEntity::GenericError, 'You are not allowed to access this resource.'
    #   end
    # end
  end
end
