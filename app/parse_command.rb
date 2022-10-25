# frozen_string_literal: true

require "./app/rules"
require "./app/models/grammar"

class ParseCommand
  # @param [String] command
  # @return ::Grammar
  def self.perform(command, state)
    new(command, state).perform
  end

  # @param [String] command
  def initialize(command, state)
    @words = command.to_s.downcase.split
    @state = state
  end

  # @return ::Grammar
  def perform
    remove_ignored_words
    map_synonyms
    add_implicit_verb

    ::Grammar.new(verb: words[0], noun: words[1], preposition: words[2], object: words[3])
  end

  private

  attr_reader :words, :state

   def remove_ignored_words
    words.reject! { |word| ::Rules::IGNORED_WORDS.include?(word) }
  end

  def map_synonyms
    words.map! { |word| ::Rules::SYNONYMS[word] || word }
  end

   def add_implicit_verb
    implicit_verb = ::Rules::IMPLICIT_VERBS[words.first]
    words.unshift(implicit_verb) if implicit_verb
  end
end
