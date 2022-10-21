# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/object/inclusion"
require "yaml"

require "./app/models/grammar"

class Parser
  SYNONYMS_FILE_PATH = "./config/synonyms.yml"
  SYNONYMS = YAML.load(File.read(SYNONYMS_FILE_PATH))

  IGNORED_WORDS_FILE_PATH = "./config/ignored_words.yml"
  IGNORED_WORDS = YAML.load(File.read(IGNORED_WORDS_FILE_PATH))

  # @param [String] command
  # @param [State] state
  # @return ::Grammar
  def self.derive_parts(command, _state)
    command = command.to_s.downcase
    words = command.split
    words.reject! { |word| word.in?(IGNORED_WORDS) }
    first, second = words
    synonym = SYNONYMS[first]
    return ::Grammar.new(verb: first, noun: second) if synonym.nil?

    synonym_first, synonym_second = synonym.split
    first = synonym_first if synonym_first.present?
    second = synonym_second if synonym_second.present?

    ::Grammar.new(verb: first, noun: second)
  end
end
