# frozen_string_literal: true

Location = Struct.new(
  :id,
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

  def general_description
    description["general"]
  end

  def details
    description.keys.reject { |key| key == "general" }
  end
end
