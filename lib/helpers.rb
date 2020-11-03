require 'date'
require 'catalogs'
require 'string_format'

module CurpGenerator::Helpers
  include CurpGenerator::Catalogs

  def verifying_digit(partial_curp)
    length_sum = 0.0

    partial_curp.split('').each_with_index do |character, index|
      length_sum += VALID_CHARACTERS.index(character) * (18 - index)
    end

    last_digit = 10 - (length_sum % 10)
    last_digit == 10 ? '0' : last_digit.to_i.to_s
  end

  def remove_composed_names(name)
    name = name.upcase

    COMPOSED_NAMES.each do |composed|
      next unless name.include?(composed)
      name = name.gsub(composed, '')
    end
    name
  end

  def parse_attribute(attribute)
    return if blank_string?(attribute)
    CurpGenerator::StringFormat.new(remove_composed_names(attribute)).str
  end

  def parse_date(date, format)
    date.strftime(format)
  end

  def blank_string?(value)
    value.to_s.strip.empty?
  end
end
