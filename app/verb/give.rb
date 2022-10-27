# frozen_string_literal: true

Dir["./app/verb/give/*.rb"].each { |file| require file }

module Verb
  class Give < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item && (subject_item.location_key == "inventory" || ::Interactions.item_takeable?(subject_item, state))
        if preposition_class.present?
          preposition_class.execute(command, state)
        elsif preposition.nil?
          "Who do you want to give the #{noun} to?"
        else
          guaranteed_object = object || "something"
          "I don't know how to give a thing #{[preposition, guaranteed_object].join(' ')}."
        end
      else
        "You aren't carrying #{noun.articleize}."
      end
    end
  end
end
