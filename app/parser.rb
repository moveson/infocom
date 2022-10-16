# frozen_string_literal: true

class Parser
  # @param [String] command
  # @param [State] state
  # @return [Array<String>]
  def self.derive_parts(command, state)
    new(command, state).derive_parts
  end

  # @param [String] command
  # @param [State] state
  def initialize(command, state)
    @command = command
    @state = state
  end

  # @return [Array<String>]
  def derive_parts
    command.split
  end

  private

  attr_reader :command, :state
end