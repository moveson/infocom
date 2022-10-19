# frozen_string_literal: true

require "./app/models/state"

class BuildInitialState
  START_GAME_FILE_PATH = "./config/basic.yml"

  def self.perform
    state = ::State.new
    ::Persist.restore_using_file_path!(state, START_GAME_FILE_PATH)
    state
  end
end
