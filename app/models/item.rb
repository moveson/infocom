# frozen_string_literal: true

Item = Struct.new(
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
  end

  alias opened? opened
  alias locked? locked

  def has_capacity?
    capacity > 0
  end

  def unlocked?
    !locked?
  end
end
