# frozen_string_literal: true

Location = Struct.new(
  :name,
  :description,
  :neighbors,
  :described,
  keyword_init: true
) do

  # Default values go here
  def initialize(*)
    super
    self.neighbors ||= {}
    self.described ||= false
  end
end
