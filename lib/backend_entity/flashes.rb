# TODO: This a fast integration of the flash-messages, which are used in the actions concern and needs to be reworked #4
# We replace here now the usage of a decorator as it was in the previous implementation! Thus alsi I18n is required!
module BackendEntity
  module Flashes
    extend ActiveSupport::Concern

    CRUD_WORDINGS = {
      create: 'erstellt',
      update: 'geändert',
      destroy: 'gelöscht'
    }.freeze

    def entity_flash_message_for(action, on: , result: false, error: nil)
      if result
        flash[:notice] = "#{entity_wording_for(on)} wurde erfolgreich #{action_wording_for(action)}."
      else
        cause = base_error_cause_for(on)
        msg = error.nil? ? "#{entity_wording_for(on)} konnte nicht #{action_wording_for(action)} werden." : error.to_s
        msg += " Grund: #{cause}" if cause.present?
        flash[:error] = msg
      end

      result
    end

    private def action_wording_for(action)
      CRUD_WORDINGS[action.to_sym]
    end

    private def entity_wording_for(entity)
      wording = entity.model_name.human.dup
      "#{wording} #{entity.to_s}"
    end

    private def base_error_cause_for(entity)
      entity.errors[:base]&.first if entity.respond_to?(:errors) && entity.errors[:base].present?
    end
  end
end