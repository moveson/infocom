# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "./lib/core_ext/string"

class BaseExecute
  # @param [Command] command
  # @param [State] state
  # @return [String]
  def self.execute(command, state)
    new(command, state).execute
  end

  # @param [String] command
  # @param [State] state
  def initialize(command, state)
    @command = command
    @noun = command.noun
    @preposition = command.preposition
    @object = command.object
    @state = state
  end

  def execute
    raise NotImplementedError
  end

  private

  attr_reader :command, :noun, :preposition, :object, :state

  def subject_item
    state.items_by_id[noun]
  end

  def preposition_class
    "#{self.class.name}::#{preposition.classify}".constantize
  end
end
