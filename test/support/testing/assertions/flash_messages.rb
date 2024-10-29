module Testing
  module Assertions
    module FlashMessages
      class FlashObjectNotPresent < StandardError; end
      class FlashMessageDefinitionInsufficient < StandardError; end

      def assert_flash_message(type:, with: nil, starts_with: nil, ends_with: nil)
        raise FlashObjectNotPresent if flash.nil?

        assert flash.key?(type)
        assert flash[type].present?

        if with.blank?
          raise FlashMessageDefinitionInsufficient if starts_with.blank? && ends_with.blank?

          assert flash[type].starts_with?(starts_with) if starts_with.present?
          assert flash[type].ends_with?(ends_with) if ends_with.present?
        else
          assert_equal with, flash[type]
        end
      end
    end
  end
end
