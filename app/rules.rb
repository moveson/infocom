# frozen_string_literal: true

require "yaml"
require "./config/constants"

class Rules
  # @param [String] adventure
  def initialize(adventure)
    @file_path = "#{::Constants::ADVENTURES_DIRECTORY}/#{adventure}/rules.yml"
  end

  def synonyms
    @synonyms ||= rules_hash["synonyms"]
  end

  def ignored_words
    @ignored_words ||= rules_hash["ignored_words"]
  end

  def implicit_verbs
    @implicit_verbs ||= rules_hash["implicit_verbs"]
  end

  private

  attr_reader :file_path

  def rules_hash
    @rules_hash ||= YAML.load(File.read(file_path))
  end
end
