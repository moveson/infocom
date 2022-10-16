# frozen_string_literal: true

module Verb
  class Inventory < ::BaseVerb
    # @return [String (frozen)]
    def execute
      if state.inventory.present?
        state.inventory.map { |item| "You have a #{item.name.downcase}" }.join("\n")
      else
        "You are not carrying anything."
      end
    end
  end
end
