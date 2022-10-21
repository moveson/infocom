# frozen_string_literal: true

class BaseVerb
  # @param [Grammar] grammar
  # @param [State] state
  # @return [String]
  def self.execute(grammar, state)
    new(grammar, state).execute
  end

  # @param [String] grammar
  # @param [State] state
  def initialize(grammar, state)
    @noun = grammar.noun
    @preposition = grammar.preposition
    @object = grammar.object
    @state = state
  end

  def execute
    raise NotImplementedError
  end

  private

  attr_reader :noun, :preposition, :object, :state

  def item
    state.items_by_id[noun]
  end
end
