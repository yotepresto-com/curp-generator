require 'curp_generator/base'

class CurpGenerator::BirthDate < CurpGenerator::Base
  def initialize(birth_date)
    @birth_date = birth_date
  end

  def self.generate(birth_date)
    new(birth_date).generate
  end

  def self.homoclave_digit(birth_date)
    new(birth_date).homoclave_digit
  end

  def generate
    validate_params
    parsed_date
  end

  def homoclave_digit
    validate_params
    @birth_date.year < 2000 ? '0' : 'A'
  end

  private

  def validate_params
    missing_birth_date_error! if blank_string?(@birth_date)
    invalid_format_error! unless @birth_date.respond_to?(:strftime)
  end

  def missing_birth_date_error!
    raise InvalidCurpArgumentError, 'Missing birth date'
  end

  def invalid_format_error!
    raise InvalidCurpArgumentError, 'Invalid date format'
  end

  def parsed_date
    @birth_date.strftime("%y%m%d")
  end
end
