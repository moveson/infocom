# frozen_string_literal: true

require "./app/persist"
require "./app/state"

RSpec.describe ::Persist do
  before { stub_const("#{described_class}::SAVED_FILE_DIRECTORY", "./spec/fixtures/files") }

  describe ".load" do
    let(:result) { described_class.load(filename) }
    let(:filename) { "saved_game_test_1" }
    let(:expected_locations) do
      {
        "quiet_meadow" => ::Location.new(
          "name" => "Quiet Meadow",
          "description" => "You find yourself in a quiet meadow.",
          "described" => false,
          "neighbors" => { "east" => "sunlit_hill", "west" => "twisted_trees" },
        ),
        "sunlit_hill" => ::Location.new(
          "name" => "Sunlit Hill",
          "description" => "A sunlit hill.",
          "described" => true,
          "neighbors" => { "west" => "quiet_meadow" },
        )
      }
    end

    let(:expected_items) do
      {
        "sword" => ::Item.new(
          "name" => "Sword",
          "description" => "a jewel-encrusted sword",
          "text" => "Sunshine makes me happy :)",
          "location_key" => "quiet_meadow",
        )
      }
    end

    context "when the file exists" do
      it "returns a State object" do
        expect(result).to be_a(::State)
      end

      it "sets state attributes as expected" do
        expect(result.location_key).to eq("quiet_meadow")
        expect(result.locations).to eq(expected_locations)
        expect(result.items).to eq(expected_items)
      end
    end
  end

  describe ".save" do
    let(:result) { described_class.save(state, filename) }
    let(:filename) { "saved_game_test_temp" }
    let(:state) { ::State.new(file_path: load_file_path) }
    let(:load_file_path) { "./spec/fixtures/files/saved_game_test_1.yml" }
    let(:temp_file_path) { described_class.path_from_filename(filename) }

    let(:expected_contents) do
      <<~CONTENTS
---
player_location: quiet_meadow
items:
  sword:
    name: Sword
    description: a jewel-encrusted sword
    text: Sunshine makes me happy :)
    location_key: quiet_meadow
locations:
  quiet_meadow:
    name: Quiet Meadow
    description: You find yourself in a quiet meadow.
    neighbors:
      east: sunlit_hill
      west: twisted_trees
    described: false
  sunlit_hill:
    name: Sunlit Hill
    description: A sunlit hill.
    neighbors:
      west: quiet_meadow
    described: true
      CONTENTS
    end

    after { File.delete(temp_file_path) if File.exist?(temp_file_path) }

    context "when the file does not exist" do
      it "returns true" do
        expect(result).to eq(true)
      end

      it "saves the file in yaml format with expected contents" do
        result
        contents = File.read(temp_file_path)
        expect(contents).to eq(expected_contents)
      end
    end
  end
end