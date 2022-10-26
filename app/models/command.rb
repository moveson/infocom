# frozen_string_literal: true

Command = Struct.new(
  :noun,
  :verb,
  :preposition,
  :object,
  keyword_init: true
)
