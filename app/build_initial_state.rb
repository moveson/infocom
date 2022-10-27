# frozen_string_literal: true

require "./app/persist"
require "./app/models/state"
require "./config/constants"

class BuildInitialState
  def self.perform(adventure)
    state = ::State.new
    file_path = "#{::Constants::ADVENTURES_DIRECTORY}/#{adventure}/initial_state.yml"
    ::Persist.restore_using_file_path!(state, file_path)
    state
  end
end
