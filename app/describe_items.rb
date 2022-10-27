# frozen_string_literal: true

require "./app/describe_item"

class DescribeItems
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
    state.items_at_player_location.each do |item|
      text_segments << ::DescribeItem.perform(item, state)
    end

    text_segments.join("\n")
  end

  private

  attr_reader :state, :text_segments
end
