# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

require "./app/interactions"
require "./lib/core_ext/string"

class BaseExecute
  # @param [Command] command
  # @param [State] state
  # @return [String (frozen), nil]
  def self.execute(command, state)
    new(command, state).execute
  end

  # @param [Command] command
  # @param [State] state
  def initialize(command, state)
    @command = command
    @verb = command.verb
    @noun = command.noun
    @preposition = command.preposition
    @object = command.object
    @state = state
  end

  # @return [String (frozen), nil]
  def execute
    missing_noun_response ||
      subject_character_response ||
      contextual_response ||
      cannot_find_response
  end

  private

  attr_reader :command, :verb, :noun, :preposition, :object, :state

  # @return [String (frozen), nil]
  def missing_noun_response
    return unless noun_required? && noun.nil?

    "You will need to say what you want to #{verb}."
  end

  def cannot_find_response
    "I don't see #{noun.articleize} here."
  end

  # @return [String (frozen), nil]
  def subject_character_response
    return if subject_character.nil?

    subject_character.reactions[verb]
  end

  def contextual_response
    raise NotImplementedError
  end

  # May be overridden in individual verb classes
  # @return [Boolean]
  def noun_required?
    true
  end

  # @return [::Character, nil]
  def object_character
    visible_character(object)
  end

  # @return [::Item, nil]
  def object_item
    visible_item(object)
  end

  # @return [Boolean]
  def object_location_detail?
    state.player_location.details.include?(object)
  end

  # @return [::Character, nil]
  def subject_character
    visible_character(noun)
  end

  # @return [::Item, nil]
  def subject_item
    visible_item(noun)
  end

  # @return [::Character, ::Item, nil]
  def subject_interactable
    subject_character || subject_item
  end

  # @return [Boolean]
  def subject_location_detail?
    state.player_location.details.include?(noun)
  end

  # @return [Class]
  def preposition_class
    return if preposition.nil?

    "#{self.class.name}::#{preposition.classify}".safe_constantize
  end

  # @param [String] id
  # @return [::Character, nil]
  def visible_character(id)
    intended_character = state.characters_by_id[id]
    return if intended_character.nil?

    ::Interactions.visible_characters(state).find { |character| character == intended_character }
  end

  # @param [String] id
  # @return [::Item, nil]
  def visible_item(id)
    intended_item = state.items_by_id[id]
    return if intended_item.nil?

    ::Interactions.visible_items(state).find { |item| item == intended_item }
  end
end
