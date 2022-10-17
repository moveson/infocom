# frozen_string_literal: true

require "./app/state"

RSpec.describe ::State do
  subject { described_class.new }

  describe "initialize" do
    it "builds an object" do
      subject
    end
  end

  describe "#location" do
    it { expect(subject.location).to be_a(::Location) }
  end
end
