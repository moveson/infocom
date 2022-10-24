# frozen_string_literal: true

require "./app/rules"

# The YAML spec includes many reserved words that translate to unexpected values.
# This spec ensures everything translates into String values.
RSpec.describe ::Rules do
  describe "SYNONYMS" do
    described_class::SYNONYMS.each do |synonym, known_word|
      context "for synonym pair #{synonym}: #{known_word}" do
        it "creates a string pair" do
          expect(synonym).to be_a(String)
          expect(known_word).to be_a(String)
        end
      end
    end
  end

  describe "IMPLICIT_VERBS" do
    described_class::IMPLICIT_VERBS.each do |noun, implicit_verb|
      context "for implicit verb pair #{noun}: #{implicit_verb}" do
        it "creates a string pair" do
          expect(noun).to be_a(String)
          expect(implicit_verb).to be_a(String)
        end
      end
    end
  end

  describe "IGNORED_WORDS" do
    described_class::IGNORED_WORDS.each do |word|
      context "for #{word}" do
        it { expect(word).to be_a(String) }
      end
    end
  end
end
