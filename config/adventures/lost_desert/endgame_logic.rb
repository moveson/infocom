# frozen_string_literal: true

module LostDesert
  class EndgameLogic
    # @param [::State] state
    # @return [Boolean]
    def self.won?(state)
      false
    end

    # @param [::State] state
    # @return [Boolean]
    def self.lost?(state)
      state.player.health <= 0
    end
  end
end
