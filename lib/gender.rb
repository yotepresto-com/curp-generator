require 'base'

class CurpGenerator::Gender < CurpGenerator::Base
  VALID_MALE_GENDERS = %w(
    male
    hombre
    masculino
  ).freeze

  VALID_FEMALE_GENDERS = %w(
    female
    mujer
    femenino
  ).freeze

  def initialize(gender)
    @gender = gender.to_s.downcase
  end

  def self.generate(gender)
    new(gender).generate
  end

  def generate
    invalid_params? ? error_message! : parsed_gender
  end

  private

  def invalid_params?
    blank_string?(@gender) || invalid_gender?
  end

  def invalid_gender?
    !VALID_MALE_GENDERS.include?(@gender) && !VALID_FEMALE_GENDERS.include?(@gender)
  end

  def error_message!
    raise InvalidCurpArgumentError, "Available gender options are #{VALID_MALE_GENDERS + VALID_FEMALE_GENDERS}"
  end

  def parsed_gender
    VALID_MALE_GENDERS.include?(@gender) ? 'H' : 'M'
  end
end
