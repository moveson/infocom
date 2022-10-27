# frozen_string_literal: true

module Verb
  class Unlock < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item
        if !subject_item.lockable?
          "You are unable to unlock the #{noun}."
        elsif subject_item.unlocked?
          "The #{noun} is already unlocked."
        elsif state.inventory.any? { |item| item.can_unlock == noun }
          subject_item.locked = false
          "You unlock the #{noun}."
        else
          "You don't have anything that will unlock the #{noun}."
        end
      elsif subject_character || subject_location_detail?
        "You can't unlock the #{noun}."
      end
    end
  end
end
