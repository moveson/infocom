# frozen_string_literal: true

module Verb
  class Talk < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if subject_character
        "There is no response."
      elsif subject_item || subject_location_detail?
        "Are you sure you're ok?"
      end
    end
  end
end
