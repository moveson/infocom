# frozen_string_literal: true

module Verb
  class Look < ::BaseVerb
    def execute
      puts state.location.description
    end
  end
end
