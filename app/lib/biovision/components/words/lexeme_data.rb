# frozen_string_literal: true

module Biovision
  module Components
    module Words
      # Helpers for normalizing lexeme data
      module LexemeData
        def lexeme_data_flags
          %w[indeclinable]
        end

        def lexeme_data_numbers
          %w[]
        end

        def lexeme_data_strings
          %w[]
        end

        def lexeme_data_enum
          {}
        end

        # @param [Hash] input
        def normalized_lexeme_data(input)
          data = normalized_lexeme_flags(input)
          data.merge! normalized_lexeme_numbers(input)
          data.merge normalized_lexeme_enum(input)
        end

        # @param [Hash] input
        def normalized_lexeme_flags(input)
          lexeme_data_flags.select { |k| input.key?(k) }.map do |key|
            [key, input[key].to_i == 1]
          end.to_h
        end

        # @param [Hash] input
        def normalized_lexeme_numbers(input)
          lexeme_data_numbers.select { |k| input.key?(k) }.map do |key|
            [key, input[key].to_i]
          end.to_h
        end

        # @param [Hash] input
        def normalized_lexeme_strings(input)
          lexeme_data_strings.select { |k| input.key?(k) }.map do |key|
            [key, input[key].to_s]
          end.to_h
        end

        # @param [Hash] input
        def normalized_lexeme_enum(input)
          data = {}
          list = lexeme_data_enum
          list.select { |k| input.key?(k) }.each do |enum|
            value = input[enum].to_i
            next unless enum.keys.include?(value)

            data[enum] = value
          end

          data
        end
      end
    end
  end
end
