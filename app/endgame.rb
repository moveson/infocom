# frozen_string_literal: true

class Endgame
  # @param [State] state
  # @return [String (frozen)]
  def self.condition(state)
    if state.player.health <= 0
      "died"
    elsif state.player_location_id == "sunlit_hill" && state.items_by_id["sword"].location_key == "items.slab"
      "won"
    elsif state.player.quitting?
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
      "You have reunited the sword with its home. Congratulations, you won!"
    when "quit"
      "Hope to see you again soon. Bye!"
    when "died"
      "You have died."
    else
      "Something went wrong and I had to exit."
    end
  end
end
