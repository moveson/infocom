# frozen_string_literal: true

class Utilities
  def self.colorize(text, mode_code = 0, color_code = 37)
    "\e[#{mode_code};#{color_code}m#{text}\e[0m"
  end
end
