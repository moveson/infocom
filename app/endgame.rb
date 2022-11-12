# frozen_string_literal: true

Dir["./config/adventures/*/endgame_logic.rb"].each { |file| require file }

class Endgame
  # @param [State] state
  # @return [String (frozen)]
  def self.condition(state)
    new(state).condition
  end

  # @param [State] state
  # @return [String (frozen)]
  def self.message(state)
    new(state).message
  end

  def initialize(state)
    @state = state
  end

  # @return [String]
  def message
    won_lost_message = state.messages[condition]
    turns_message = "Number of turns: #{state.player.turn_count}\n\n"

    [won_lost_message, turns_message].join("\n")
  end

  # @return [String (frozen)]
  def condition
    @condition ||=
      if endgame_logic_class.won?(state)
        "won"
      elsif endgame_logic_class.lost?(state)
        "lost"
      else
        "in_progress"
      end
  end

  private

  attr_reader :state

  # @return [Class]
  def endgame_logic_class
    "::#{state.adventure.camelize}::EndgameLogic".constantize
  end
end
