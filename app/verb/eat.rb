# frozen_string_literal: true

module Verb
  class Eat < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if subject_character
        "Yikes, no thanks."
      elsif subject_location_detail?
        "You can't eat the #{noun}."
      elsif subject_item
        if subject_item.edible?
          subject_item.location_key = "hidden"
          "Delicious."
        else
          "It isn't edible."
        end
      end
    end
  end
end
