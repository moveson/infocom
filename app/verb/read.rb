# frozen_string_literal: true

module Verb
  class Read < ::BaseExecute
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "You will need to say what you want me to read."
      elsif subject_item.nil?
        "I don't see #{noun.articleize} here."
      elsif subject_item.location_key == state.player_location_id
        "You have to hold something before reading it."
      elsif subject_item.location_key == "inventory"
        if subject_item.text.present?
          "It says, '#{subject_item.text}'"
        else
          "There's nothing to read on the #{subject_item.name}."
        end
      else
        "I don't see #{noun.articleize} here."
      end
    end
  end
end
