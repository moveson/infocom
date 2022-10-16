# frozen_string_literal: true

require "yaml"

class Parser
  SYNONYMS_FILE_PATH = "./config/synonyms.yml"
  SYNONYMS = YAML.load(File.read(SYNONYMS_FILE_PATH))

  # @param [String] command
  # @param [State] state
  # @return [Array<String>]
  def self.derive_parts(command, state)
    new(command, state).derive_parts
  end

  # @param [String] command
  # @param [State] state
  def initialize(command, state)
    @command = command.to_s
    @state = state
  end

  # @return [Array<String>]
  def derive_parts
    first, second = command.downcase.split
    synonym = SYNONYMS[first]
    return [first, second] if synonym.nil?

    synonym_first, synonym_second = synonym.split
    first = synonym_first if synonym_first.present?
    second = synonym_second if synonym_second.present?

    [first, second]
  end

  private

  attr_reader :command, :state
end
