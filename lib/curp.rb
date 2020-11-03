require 'version'
require 'catalogs'
require 'element'
require 'helpers'

class CurpGenerator::Curp
  include CurpGenerator::Catalogs
  include CurpGenerator::Helpers

  MissingParamError = Class.new(StandardError)

  PARAMS_TO_VALIDATE = %w(
    first_last_name
    first_name
    birth_date
    birth_state
    gender
  ).freeze

  def initialize(data = {})
    @first_name       = data.dig(:first_name)
    @second_name      = data.dig(:second_name)
    @first_last_name  = parse_attribute(data.dig(:first_last_name))
    @second_last_name = parse_attribute(data.dig(:second_last_name)) || ''
    @birth_date       = data.dig(:birth_date)
    @birth_state      = parse_attribute(data.dig(:birth_state))
    @gender           = data.dig(:gender)
  end

  def generate
    validate_params

    prefix = partial_curp
    prefix + verifying_digit(prefix)
  end

  private

  def validate_params
    PARAMS_TO_VALIDATE.each do |param|
      raise MissingParamError, "Missing #{param}" if blank_string?(instance_variable_get("@#{param}"))
    end
  end

  def partial_curp
    validate_first_four_curp_digits +
    parse_date(@birth_date, "%y") +
    parse_date(@birth_date, "%m") +
    parse_date(@birth_date, "%d") +
    gender_character +
    state_code +
    first_last_name_element.next_consonant +
    second_last_name_element.next_consonant +
    first_name_element.next_consonant +
    homoclave_digit
  end

  def validate_first_four_curp_digits
    FORBIDDEN_WORDS.dig(first_four_curp_digits) || first_four_curp_digits
  end

  def gender_character
    @gender == 'male' ? 'H' : 'M'
  end

  def state_code
    STATES.dig(@birth_state.upcase) || 'NE'
  end

  def homoclave_digit
    @birth_date.year < 2000 ? '0' : 'A'
  end

  def first_four_curp_digits
    @first_four_curp_digits ||=
      first_last_name_element.first_character +
      first_last_name_element.next_vowel +
      second_last_name_element.first_character +
      first_name_element.first_character
  end

  def first_last_name_element
    @first_last_name_element ||= CurpGenerator::Element.new(@first_last_name)
  end

  def second_last_name_element
    @second_last_name_element ||= CurpGenerator::Element.new(@second_last_name)
  end

  def first_name_element
    @first_name_element ||= CurpGenerator::Element.new(validate_first_name)
  end

  def validate_first_name
    name = parse_attribute(@first_name)
    COMMON_NAMES.include?(name) ? @second_name : name
  end
end
