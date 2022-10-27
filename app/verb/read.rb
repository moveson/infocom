# frozen_string_literal: true

module Verb
  class Read < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item
        if subject_item.text.present?
          "It says, '#{subject_item.text}'"
        else
          "There's nothing to read on the #{subject_item.name}."
        end
      elsif subject_character || subject_location_detail?
        "You can't read the #{noun}."
      end
    end
  end
end
