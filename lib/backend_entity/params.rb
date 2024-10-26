module BackendEntity
  module Params
    extend ActiveSupport::Concern

    # protected def entity_params
    #   params.require(entity_name.underscore.to_sym).permit(*entity_class.column_names)
    # end

    protected def new_action?
      params[:action].eql?('new')
    end

    protected def edit_action?
      params[:action].eql?('edit')
    end
  end
end
