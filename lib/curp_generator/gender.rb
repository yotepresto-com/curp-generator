require 'curp_generator/base'

class CurpGenerator::Gender < ::CurpGenerator::Base
  VALID_MALE_GENDERS = %w[
    male
    hombre
    masculino
    h
  ].freeze

  VALID_FEMALE_GENDERS = %w[
    female
    mujer
    femenino
    m
  ].freeze

  def initialize(gender)
    @gender = gender.to_s.downcase
  end

  def self.generate(gender)
    new(gender).generate
  end

  def generate
    validate_params
    parsed_gender
  end

  private

  def validate_params
    missing_gender_error! if blank_string?(@gender)
    invalid_gender_error! if invalid_gender?
  end

  def invalid_gender?
    !VALID_MALE_GENDERS.include?(@gender) && !VALID_FEMALE_GENDERS.include?(@gender)
  end

  def missing_gender_error!
    raise InvalidCurpArgumentError, 'Missing gender'
  end

  def invalid_gender_error!
    raise InvalidCurpArgumentError, "Available gender options are #{VALID_MALE_GENDERS + VALID_FEMALE_GENDERS}"
  end

  def parsed_gender
    VALID_MALE_GENDERS.include?(@gender) ? 'H' : 'M'
  end
end
