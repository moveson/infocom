# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/object/inclusion"
require "yaml"

require "./app/models/grammar"

class ParseCommand
  RULES_FILE_PATH = "./config/rules.yml"
  RULES_HASH = YAML.load(File.read(RULES_FILE_PATH))
  SYNONYMS = RULES_HASH["synonyms"]
  IGNORED_WORDS = RULES_HASH["ignored_words"]

  DIRECTIONS = %w[north east south west]

  # @param [String] command
  # @param [State] state
  # @return ::Grammar
  def self.perform(command, _state)
    command = command.to_s.downcase
    words = command.split
    words.reject! { |word| word.in?(IGNORED_WORDS) }
    words.map! { |word| SYNONYMS[word].present? ? SYNONYMS[word] : word }
    words.unshift("go") if DIRECTIONS.include?(words[0])

    ::Grammar.new(verb: words[0], noun: words[1], preposition: words[2], object: words[3])
  end
end
