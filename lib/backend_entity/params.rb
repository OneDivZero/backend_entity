module BackendEntity
  module Params
    extend ActiveSupport::Concern

    # protected def entity_params
    #   params.require(entity_name.underscore.to_sym).permit(*entity_class.column_names)
    # end

    protected def new_action?
      # NoMethodError: undefined method `filtered_parameters' for nil:NilClass
      # /Users/michael.ajwani/.asdf/installs/ruby/3.0.5/lib/ruby/gems/3.0.0/gems/actionpack-7.1.4/lib/action_controller/metal/strong_parameters.rb:1327:in `params'
      # lib/backend_entity/params.rb:10:in `new_action?'
      # lib/backend_entity/fetching.rb:20:in `load_entity'
      # test/lib/backend_entity/fetching_test.rb:41:in `block (2 levels) in <class:FetchingTest>'

      # params[:action].eql?('new')
      true
    end

    protected def edit_action?
      params[:action].eql?('edit')
    end
  end
end
