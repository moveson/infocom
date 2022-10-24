# frozen_string_literal: true

require "yaml"

class Rules
  RULES_FILE_PATH = "./config/rules.yml"
  RULES_HASH = YAML.load(File.read(RULES_FILE_PATH))

  SYNONYMS = RULES_HASH["synonyms"]
  IGNORED_WORDS = RULES_HASH["ignored_words"]
  IMPLICIT_VERBS = RULES_HASH["implicit_verbs"]
end
