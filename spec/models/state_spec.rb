# frozen_string_literal: true

require "./app/persist"
require "./app/models/state"

RSpec.describe ::State do
  subject { described_class.new }

  describe "#player_location" do
    let(:result) { subject.player_location }
    let(:test_file_path) { "./spec/fixtures/files/saved_game_test_1.yml" }
    before { ::Persist.restore_using_file_path!(subject, test_file_path) }

    it "returns the expected Location object" do
      expect(result).to be_a(::Location)
      expect(result.name).to eq("Quiet Meadow")
    end
  end
end
