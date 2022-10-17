# frozen_string_literal: true

class Endgame
  def self.set_state(state)
    if state.location_key == "deadly_pit"
      state.lost = true
    elsif state.location_key == "sunlit_hill" && state.items["sword"].location_key == "inventory"
      state.won = true
    end
  end

  def self.print_message(state)
    message = if state.won?
                "You made it to the hill with the sword. Congratulations, you won!"
              elsif state.quit?
                "Hope to see you again soon. Bye!"
              else
                "Sorry, you lost."
              end

    puts "#{message}\n\n"
  end
end
