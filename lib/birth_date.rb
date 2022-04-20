require 'base'

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
    invalid_params? ? error_message! : parsed_date
  end

  def homoclave_digit
    @birth_date.year < 2000 ? '0' : 'A'
  end

  private

  def invalid_params?
    blank_string?(@birth_date) || !@birth_date.respond_to?(:strftime)
  end

  def error_message!
    raise InvalidCurpArgumentError, 'Invalid date format'
  end

  def parsed_date
    @birth_date.strftime("%y%m%d")
  end
end
