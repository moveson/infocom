# frozen_string_literal: true

require "active_support"
require "yaml"

require "./app/models/grammar"

class Parser
  SYNONYMS_FILE_PATH = "./config/synonyms.yml"
  SYNONYMS = YAML.load(File.read(SYNONYMS_FILE_PATH))

  # @param [String] command
  # @param [State] state
  # @return ::Grammar
  def self.derive_parts(command, _state)
    command = command.to_s
    first, second = command.downcase.split
    synonym = SYNONYMS[first]
    return ::Grammar.new(verb: first, noun: second) if synonym.nil?

    synonym_first, synonym_second = synonym.split
    first = synonym_first if synonym_first.present?
    second = synonym_second if synonym_second.present?

    ::Grammar.new(verb: first, noun: second)
  end
end
