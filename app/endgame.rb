# frozen_string_literal: true

class Endgame
  # @param [State] state
  # @return [String (frozen)]
  def self.condition(state)
    if state.player_location_key == "deadly_pit"
      "lost"
    elsif state.player_location_key == "sunlit_hill" && state.items["sword"].location_key == "inventory"
      "won"
    elsif state.context.verb == "quit"
      "quit"
    else
      "in_progress"
    end
  end

  # @param [State] state
  # @return [String (frozen)]
  def self.message(state)
    case condition(state)
    when "won"
      "You made it to the hill with the sword. Congratulations, you won!"
    when "quit"
      "Hope to see you again soon. Bye!"
    when "lost"
      "Sorry, you lost."
    else
      "Something went wrong and I had to exit."
    end
  end
end
