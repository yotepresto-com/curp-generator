require 'base'

class CurpGenerator::State < CurpGenerator::Base
  include CurpGenerator::Catalogs

  def initialize(birth_state)
    @birth_state = parse_attribute(birth_state&.upcase)
  end

  def self.generate(birth_state)
    new(birth_state).generate
  end

  def generate
    invalid_params? ? error_message! : parsed_state
  end

  private

  def invalid_params?
    blank_string?(@birth_state)
  end

  def error_message!
    raise InvalidCurpArgumentError, 'Missing birth state argument'
  end

  def parsed_state
    STATES[@birth_state.upcase] || 'NE'
  end
end
