# frozen_string_literal: true

module Porters
  # Indeclinable lexeme
  class Indeclinable < BasePorter
    def lexeme_data
      { 'indeclinable' => 1 }
    end
  end
end
