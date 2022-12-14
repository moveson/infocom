# frozen_string_literal: true

module Verb
  class Describe < ::BaseExecute
    private

    # @return [String (frozen), nil]
    def contextual_response
      if subject_location_detail?
        state.player_location.description[noun]
      elsif subject_character
        subject_character.description
      elsif subject_item
        subject_item.described = false
        ::DescribeItem.perform(subject_item, state)
      end
    end
  end
end
