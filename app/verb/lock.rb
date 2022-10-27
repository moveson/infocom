# frozen_string_literal: true

module Verb
  class Lock < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item
        if subject_item.locked?
          "The #{noun} is already locked."
        elsif state.inventory.any? { |item| item.can_unlock == noun }
          subject_item.locked = true
          "You lock the #{noun}."
        elsif subject_item.lockable?
          "You don't have anything that will lock the #{noun}."
        else
          "You can't lock the #{noun}."
        end
      end
    end
  end
end
