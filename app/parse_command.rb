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
  IMPLICIT_VERBS = RULES_HASH["implicit_verbs"]

  # @param [String] command
  # @param [State] state
  # @return ::Grammar
  def self.perform(command, _state)
    command = command.to_s.downcase
    words = command.split
    remove_ignored_words(words)
    map_synonyms(words)
    add_implicit_verb(words)

    ::Grammar.new(verb: words[0], noun: words[1], preposition: words[2], object: words[3])
  end

  private_class_method def self.remove_ignored_words(words)
    words.reject! { |word| word.in?(IGNORED_WORDS) }
  end

  private_class_method def self.map_synonyms(words)
    words.map! { |word| SYNONYMS[word].present? ? SYNONYMS[word] : word }
  end

  private_class_method def self.add_implicit_verb(words)
    implicit_verb = IMPLICIT_VERBS[words.first]
    words.unshift(implicit_verb) if implicit_verb.present?
  end
end
