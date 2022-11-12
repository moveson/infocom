# frozen_string_literal: true

module Primis
  class EndgameLogic
    # @param [::State] state
    # @return [Boolean]
    def self.won?(state)
      state.items_by_id["sword"].location_key == "items.slab"
    end

    # @param [::State] state
    # @return [Boolean]
    def self.lost?(state)
      state.player.health <= 0
    end
  end
end
