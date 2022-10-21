# frozen_string_literal: true

Item = Struct.new(
  :id,
  :name,
  :description,
  :text,
  :location_key,
  :size,
  :capacity,
  :locked,
  :opened,
  :can_unlock,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.capacity ||= 0
    self.locked ||= false
    self.opened ||= false
    self.can_unlock ||= []
  end

  alias opened? opened
  alias locked? locked

  def has_capacity?
    capacity > 0
  end

  def closed?
    !opened?
  end

  def contained?
    location_key.start_with?("item")
  end

  def container_id
    return unless contained?

    location_key.split(".").last
  end

  def unlocked?
    !locked?
  end
end
