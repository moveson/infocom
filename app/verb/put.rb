# frozen_string_literal: true

Dir["./app/verb/put/*.rb"].each { |file| require file }

module Verb
  class Put < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if noun.nil?
        "What did you want to put?"
      elsif item.location_key == "inventory"
        if preposition == "in" || preposition == "into"
          Put::In.execute(grammar, state)
        elsif preposition == "on" || preposition == "onto"
          Put::On.execute(grammar, state)
        elsif preposition.nil?
          "You are going to have to say where you want to put the #{noun}."
        else
          guaranteed_object = object || "something"
          "I don't know how to put a thing #{[preposition, guaranteed_object].join(' ')}."
        end
      else
        "You aren't carrying a #{noun}."
      end
    end
  end
end
