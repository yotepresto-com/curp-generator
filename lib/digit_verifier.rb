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
    validate_params
    verifying_digit
  end

  private

  def validate_params
    missing_partial_curp_error! if blank_string?(@partial_curp)
    invalid_size_error! if @partial_curp.size != 17
  end

  def missing_partial_curp_error!
    raise InvalidCurpArgumentError, 'Missing partial curp'
  end

  def invalid_size_error!
    raise InvalidCurpArgumentError, 'Invalid partial curp size'
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
