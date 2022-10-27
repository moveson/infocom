# frozen_string_literal: true

Dir["./app/verb/put/*.rb"].each { |file| require file }

module Verb
  class Put < ::BaseExecute
    private

    # @return [String (frozen)]
    def contextual_response
      if subject_item&.location_key == "inventory" || ::Interactions.item_takeable?(subject_item, state)
        if preposition_class.present?
          preposition_class.execute(command, state)
        elsif preposition.nil?
          "You are going to have to say where you want to put the #{noun}."
        else
          guaranteed_object = object || "something"
          "I don't know how to put a thing #{[preposition, guaranteed_object].join(' ')}."
        end
      else
        "You aren't carrying #{noun.articleize}."
      end
    end
  end
end
