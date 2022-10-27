# frozen_string_literal: true

require "./app/rules"

# The YAML spec includes many reserved words that translate to unexpected values.
# This spec ensures everything translates into String values.
RSpec.describe ::Rules do
  available_adventures = Dir["#{::Constants::ADVENTURES_DIRECTORY}/*"].map { |path| path.split("/").last }
  available_adventures.each do |adventure|
    context "for #{adventure}" do
      rules = described_class.new(adventure)

      describe "#synonyms" do
        rules.synonyms.each do |synonym, known_word|
          context "for synonym pair #{synonym}: #{known_word}" do
            it "creates a string pair" do
              expect(synonym).to be_a(String)
              expect(known_word).to be_a(String)
            end
          end
        end
      end

      describe "#implicit_verbs" do
        rules.implicit_verbs.each do |noun, implicit_verb|
          context "for implicit verb pair #{noun}: #{implicit_verb}" do
            it "creates a string pair" do
              expect(noun).to be_a(String)
              expect(implicit_verb).to be_a(String)
            end
          end
        end
      end

      describe "#ignored_words" do
        rules.ignored_words.each do |word|
          context "for #{word}" do
            it { expect(word).to be_a(String) }
          end
        end
      end
    end
  end
end
