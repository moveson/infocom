# frozen_string_literal: true

Player = Struct.new(
  :location_id,
  :health,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.health ||= 0
  end
end
