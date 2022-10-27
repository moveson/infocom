# frozen_string_literal: true

Character = Struct.new(
  :id,
  :name,
  :description,
  :described,
  :location_key,
  :reactions,
  :trades,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.described ||= false
    self.reactions ||= {}
    self.trades ||= {}
  end

  alias described? described
end
