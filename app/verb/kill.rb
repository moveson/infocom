# frozen_string_literal: true

module Verb
  class Kill < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if subject_character
        "That would be cruel."
      elsif subject_item || subject_location_detail?
        "How can you kill that which has no life?"
      end
    end
  end
end
