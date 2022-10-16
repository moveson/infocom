# frozen_string_literal: true

class BaseVerb
  # @param [String] noun
  # @param [State] state
  # @return [String]
  def self.execute(noun, state)
    new(noun, state).execute
  end

  # @param [String] noun
  # @param [State] state
  def initialize(noun, state)
    @noun = noun
    @state = state
  end

  def execute
    raise NotImplementedError
  end

  private

  attr_reader :noun, :state
end
