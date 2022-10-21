# frozen_string_literal: true

Item = Struct.new(
  :name,
  :description,
  :text,
  :location_key,
  :size,
  :capacity,
  :locked,
  :open,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.capacity ||= 0
    self.locked ||= false
    self.open ||= false
  end
end
