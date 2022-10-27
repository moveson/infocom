# frozen_string_literal: true

module Verb
  class Close < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if subject_item
        if subject_item.opened?
          subject_item.opened = false
          "You close the #{noun}."
        else
          "The #{noun} is not open."
        end
      elsif subject_character || subject_location_detail?
        "You can't close the #{noun}."
      end
    end
  end
end
