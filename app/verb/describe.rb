# frozen_string_literal: true

module Verb
  class Describe < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if subject_location_detail?
        state.player_location.description[noun]
      elsif subject_interactable
        subject_interactable.described = true
        subject_interactable.description
      end
    end
  end
end
