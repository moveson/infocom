# frozen_string_literal: true

module Verb
  class Open < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item
        if subject_item.opened?
          "The #{noun} is already open."
        elsif !subject_item.openable?
          "You are unable to open the #{noun}."
        elsif subject_item.unlocked?
          subject_item.opened = true
          "You open the #{noun}."
        else
          "The #{noun} is locked."
        end
      elsif subject_character || subject_location_detail?
        "You can't open the #{noun}."
      end
    end
  end
end
