# frozen_string_literal: true

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
      text_segments << "You see #{item.description}"
      if (item.openable? && item.opened?) || item.surface?
        add_text_from_contents(item)
      end
    end

    text_segments.join("\n")
  end

  private

  attr_reader :state, :text_segments

  # @param [Item] item
  def add_text_from_contents(item)
    contents = state.children_of_item(item)

    if item.container?
      if contents.present?
        text_segments << "  The #{item.name.downcase} contains:"
        contents.each do |contained_item|
          text_segments << "    a #{contained_item.name.downcase}"
        end
      else
        text_segments << "  The #{item.name.downcase} is empty"
      end
    elsif item.surface?
      if contents.present?
        text_segments << "  On the #{item.name.downcase} is:"
        contents.each do |contained_item|
          text_segments << "    a #{contained_item.name.downcase}"
        end
      end
    end
  end
end
