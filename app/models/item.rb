# frozen_string_literal: true

Item = Struct.new(
  :id,
  :name,
  :description,
  :described,
  :text,
  :location_key,
  :size,
  :capacity,
  :lockable,
  :locked,
  :openable,
  :opened,
  :edible,
  :can_unlock,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.described ||= false
    self.capacity ||= 0
    self.lockable ||= false
    self.locked ||= false
    self.openable ||= false
    self.opened ||= false
    self.edible ||= false
    self.can_unlock ||= []
  end

  alias described? described
  alias lockable? lockable
  alias locked? locked
  alias openable? openable
  alias opened? opened
  alias edible? edible

  def container?
    openable? && capacity > 0
  end

  def closed?
    !opened?
  end

  def child_of_item?
    location_key.start_with?("item")
  end

  def children_possible?
    container? || surface?
  end

  def children_visible?
    opened? || surface?
  end

  def parent_item_id
    return unless child_of_item?

    location_key.split(".").last
  end

  def surface?
    !openable? && capacity > 0
  end

  def unlocked?
    !locked?
  end
end
