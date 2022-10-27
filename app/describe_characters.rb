# frozen_string_literal: true

class DescribeCharacters
  # @param [::State] state
  # @return [String]
  def self.perform(state)
    new(state).perform
  end

  # @param [::State] state
  def initialize(state)
    @state = state
    @text_segments = []
  end

  # @return [String]
  def perform
    state.characters_at_player_location.each do |character|
      character_text = character.described? ? "There is #{character.name.articleize} here" : character.description
      text_segments << character_text
      character.described = true
    end

    text_segments.join("\n")
  end

  private

  attr_reader :state, :text_segments
end
