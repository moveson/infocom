# frozen_string_literal: true

require "./app/interactions"
require "./app/rules"
require "./app/models/command"

class ParseInput
  # @param [String] input_text
  # @return ::Command
  def self.perform(input_text, state)
    new(input_text, state).perform
  end

  # @param [String] input_text
  def initialize(input_text, state)
    @words = input_text.to_s.downcase.split
    @state = state
  end

  # @return ::Command
  def perform
    remove_ignored_words
    map_visible_item_names
    map_synonyms
    add_implicit_verb

    ::Command.new(verb: words[0], noun: words[1], preposition: words[2], object: words[3])
  end

  private

  attr_reader :words, :state

  def remove_ignored_words
    words.reject! { |word| ::Rules::IGNORED_WORDS.include?(word) }
  end

  def map_visible_item_names
    visible_items = ::Interactions.visible_items(state)

    words.each_cons(2).with_index do |word_pair, index|
      matching_item = visible_items.find { |item| item.name == word_pair.join(" ") }

      if matching_item
        words[index] = matching_item.id
        words.delete_at(index + 1)
      end
    end
  end

  def map_synonyms
    words.map! { |word| ::Rules::SYNONYMS[word] || word }
  end

  def add_implicit_verb
    implicit_verb = ::Rules::IMPLICIT_VERBS[words.first]
    words.unshift(implicit_verb) if implicit_verb
  end
end