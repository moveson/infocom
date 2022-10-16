# frozen_string_literal: true

Location = Struct.new(
  :name,
  :description,
  :neighbors,
  :described,
  keyword_init: true
)
