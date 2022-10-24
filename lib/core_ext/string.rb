# frozen_string_literal: true

require "./lib/inflections"

class String
  def articleize
    "#{::Inflections.indefinite_article(self)} #{self}"
  end
end
