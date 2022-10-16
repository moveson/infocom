# frozen_string_literal: true

Item = Struct.new(
  :name,
  :description,
  :location_key,
  keyword_init: true
)
