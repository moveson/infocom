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
      item_text = item.described? ? item.name.articleize : item.description
      text_segments << "You see #{item_text}"
      item.described = true

      if item.children_visible?
        add_text_from_contents(item)
      elsif item.lockable? && item.unlocked? && item.closed?
        text_segments << "  The #{item.id} is closed"
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
        text_segments << "  The #{item.id} contains:"
        contents.each do |contained_item|
          text_segments << "    #{contained_item.name.articleize}"
        end
      else
        text_segments << "  The #{item.id} is empty"
      end
    elsif item.surface?
      if contents.present?
        text_segments << "  On the #{item.id} is:"
        contents.each do |contained_item|
          text_segments << "    #{contained_item.name.articleize}"
        end
      end
    end
  end
end
