# frozen_string_literal: true

require "./app/interactions"

class DescribeItem
  # @param [::Item] item
  # @param [::State] state
  # @return [String]
  def self.perform(item, state)
    new(item, state).perform
  end

  # @param [::Item] item
  # @param [::State] state
  def initialize(item, state)
    @item = item
    @state = state
    @text_segments = []
  end

  # @return [String]
  def perform
    item_text = item.described? ? item.name.articleize : item.description
    text_segments << "You see #{item_text}"
    item.described = true

    if item.children_visible?
      add_text_from_contents
    elsif item.lockable? && item.unlocked? && item.closed?
      text_segments << "  The #{item.id} is closed"
    end

    text_segments.join("\n")
  end

  private

  attr_reader :item, :state, :text_segments

  def add_text_from_contents
    contents = ::Interactions.children_of_item(item, state)

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
