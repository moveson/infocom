# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "./lib/core_ext/string"

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
    @grammar = grammar
    @noun = grammar.noun
    @preposition = grammar.preposition
    @object = grammar.object
    @state = state
  end

  def execute
    raise NotImplementedError
  end

  private

  attr_reader :grammar, :noun, :preposition, :object, :state

  def item
    state.items_by_id[noun]
  end

  def preposition_class
    "#{self.class.name}::#{preposition.classify}".constantize
  end
end
