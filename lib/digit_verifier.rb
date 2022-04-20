require 'base'

class CurpGenerator::DigitVerifier < CurpGenerator::Base
  VALID_CHARACTERS = '0123456789ABCDEFGHIJKLMNÑOPQRSTUVWXYZ'.freeze

  def initialize(partial_curp)
    @partial_curp = partial_curp
  end

  def self.generate(partial_curp)
    new(partial_curp).generate
  end

  def generate
    invalid_params? ? error_message! : verifying_digit
  end

  private

  def invalid_params?
    blank_string?(@partial_curp) || @partial_curp.size != 17
  end

  def error_message!
    raise InvalidCurpArgumentError, 'Missing partial curp'
  end

  def verifying_digit
    length_sum = 0.0

    @partial_curp.split('').each_with_index do |character, index|
      length_sum += VALID_CHARACTERS.index(character) * (18 - index)
    end

    last_digit = 10 - (length_sum % 10)
    last_digit == 10 ? '0' : last_digit.to_i.to_s
  end
end
