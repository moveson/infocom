# frozen_string_literal: true

Player = Struct.new(
  :location_id,
  :health,
  :turn_count,
  :quitting,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.health ||= 0
    self.turn_count ||= 0
    self.quitting = false
  end

  alias quitting? quitting
end
