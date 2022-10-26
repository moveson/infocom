# frozen_string_literal: true

require "./app/persist"
require "./app/models/state"

RSpec.describe ::Persist do
  before { stub_const("#{described_class}::SAVED_FILE_DIRECTORY", "./spec/fixtures/files") }

  describe ".restore_using_filename!" do
    let(:result) { described_class.restore_using_filename!(state, filename) }
    let(:state) { ::State.new }
    let(:filename) { "saved_game_test_1" }
    let(:expected_locations) { [meadow_location, hill_location] }
    let(:expected_items) { [sword_item, key_item, chest_item] }

    let(:meadow_location) do
      ::Location.new(
        "id" => "quiet_meadow",
        "name" => "Quiet Meadow",
        "description" => "You find yourself in a quiet meadow.",
        "described" => false,
        "neighbors" => { "east" => "sunlit_hill", "west" => "twisted_trees" },
      )
    end

    let(:hill_location) do
      ::Location.new(
        "id" => "sunlit_hill",
        "name" => "Sunlit Hill",
        "description" => "A sunlit hill.",
        "described" => true,
        "neighbors" => { "west" => "quiet_meadow" },
      )
    end

    let(:chest_item) do
      ::Item.new(
        id: "chest",
        name: "chest",
        description: "a large oaken chest with a heavy lock",
        location_key: "tropical_forest",
        size: 999,
        capacity: 100,
        lockable: true,
        locked: true,
        openable: true,
        opened: false,
      )
    end

    let(:key_item) do
      ::Item.new(
        id: "key",
        name: "iron key",
        description: "a solid iron key",
        location_key: "twisted_trees",
        size: 3,
        can_unlock: ["chest"]
      )
    end

    let(:sword_item) do
      ::Item.new(
        id: "sword",
        name: "engraved sword",
        description: "a jewel-encrusted sword",
        text: "Sunshine makes me happy :)",
        location_key: "items.chest",
        size: 30,
      )
    end

    context "when the file exists" do
      it "returns true" do
        expect(result).to eq(true)
      end

      it "modifies state attributes as expected" do
        result
        expect(state.player_location_id).to eq("quiet_meadow")
        expect(state.locations).to match_array(expected_locations)
        expect(state.items).to match_array(expected_items)
      end
    end

    context "when the file does not exist" do
      let(:filename) { "does_not_exist" }

      it "returns false" do
        expect(result).to eq(false)
      end

      it "does not modify the state" do
        result
        expect(state.player_location_id).to be_nil
        expect(state.locations).to be_empty
        expect(state.items).to be_empty
        expect(state.context).to eq(::Context.new)
      end
    end
  end

  describe ".save" do
    let(:result) { described_class.save(state, filename) }
    let(:filename) { "saved_game_test_temp" }
    let(:state) { ::State.new }
    let(:load_file_path) { "./spec/fixtures/files/saved_game_test_1.yml" }
    let(:temp_file_path) { described_class.path_from_filename(filename) }

    let(:expected_contents) do
      <<~CONTENTS
        ---
        player:
          location_id: quiet_meadow
        items:
        - id: sword
          name: engraved sword
          description: a jewel-encrusted sword
          described: false
          text: Sunshine makes me happy :)
          location_key: items.chest
          size: 30
          capacity: 0
          lockable: false
          locked: false
          openable: false
          opened: false
          can_unlock: []
        - id: key
          name: iron key
          description: a solid iron key
          described: false
          text:
          location_key: twisted_trees
          size: 3
          capacity: 0
          lockable: false
          locked: false
          openable: false
          opened: false
          can_unlock:
          - chest
        - id: chest
          name: chest
          description: a large oaken chest with a heavy lock
          described: false
          text:
          location_key: tropical_forest
          size: 999
          capacity: 100
          lockable: true
          locked: true
          openable: true
          opened: false
          can_unlock: []
        locations:
        - id: quiet_meadow
          name: Quiet Meadow
          description: You find yourself in a quiet meadow.
          neighbors:
            east: sunlit_hill
            west: twisted_trees
          described: false
        - id: sunlit_hill
          name: Sunlit Hill
          description: A sunlit hill.
          neighbors:
            west: quiet_meadow
          described: true
        context:
          verb:
          noun:
        turn_count: 0
      CONTENTS
    end

    before { described_class.restore_using_file_path!(state, load_file_path) }
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
