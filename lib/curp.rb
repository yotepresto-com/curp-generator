require 'version'
require 'catalogs'
require 'name'
require 'birth_date'
require 'digit_verifier'
require 'gender'
require 'state'

class CurpGenerator::Curp
  include CurpGenerator::Catalogs

  InvalidArgumentError = Class.new(StandardError)

  def initialize(data={})
    @first_name       = data[:first_name]
    @second_name      = data[:second_name]
    @first_last_name  = data[:first_last_name]
    @second_last_name = data[:second_last_name]
    @birth_date       = data[:birth_date]
    @birth_state      = data[:birth_state]
    @gender           = data[:gender]
  end

  def generate
    "#{partial_curp}#{verifier_digit}"
  rescue => e
    raise InvalidArgumentError, e
  end

  private

  def partial_curp
    @partial_curp ||= prefix_name +
      parsed_date +
      gender_character +
      state_character +
      sufix_name +
      homoclave_digit
  end

  def verifier_digit
    CurpGenerator::DigitVerifier.generate(partial_curp)
  end

  def prefix_name
    CurpGenerator::Name.prefix_name(@first_name, @second_name, @first_last_name, @second_last_name)
  end

  def parsed_date
    CurpGenerator::BirthDate.generate(@birth_date)
  end

  def gender_character
    CurpGenerator::Gender.generate(@gender)
  end

  def state_character
    CurpGenerator::State.generate(@birth_state)
  end

  def sufix_name
    CurpGenerator::Name.sufix_name(@first_name, @second_name, @first_last_name, @second_last_name)
  end

  def homoclave_digit
    CurpGenerator::BirthDate.homoclave_digit(@birth_date)
  end
end
