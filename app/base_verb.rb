# frozen_string_literal: true

class BaseVerb
  def self.execute(noun, state)
    new(noun, state).execute
  end

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
