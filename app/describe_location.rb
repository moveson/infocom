# frozen_string_literal: true

class DescribeLocation
  def self.perform(state)
    text_segments = [""] # Blank line before the location name
    text_segments << ::Text.colorize(state.player_location.name.titleize, 1)
    text_segments << state.player_location.description unless state.player_location.described

    state.player_location.described = true

    text_segments.join("\n")
  end
end
