require 'base'
require 'catalogs'

class CurpGenerator::Name < CurpGenerator::Base
  include CurpGenerator::Catalogs

  def initialize(first_name, second_name, first_last_name, second_last_name)
    @first_name       = parse_attribute(first_name&.upcase)
    @second_name      = parse_attribute(second_name&.upcase)
    @first_last_name  = parse_attribute(first_last_name&.upcase)
    @second_last_name = parse_attribute(second_last_name&.upcase)
  end

  def self.prefix_name(first_name, second_name, first_last_name, second_last_name)
    new(first_name, second_name, first_last_name, second_last_name).prefix_name
  end

  def self.sufix_name(first_name, second_name, first_last_name, second_last_name)
    new(first_name, second_name, first_last_name, second_last_name).sufix_name
  end

  def generate
    error_message! if invalid_params?
  end

  def prefix_name
    generate
    FORBIDDEN_WORDS[prefix_consonants] || prefix_consonants
  end

  def sufix_name
    generate
    sufix_consonants
  end

  private

  def invalid_params?
    blank_string?(@first_name) || blank_string?(@first_last_name)
  end

  def error_message!
    raise InvalidCurpArgumentError, 'Invalid name arguments'
  end

  def prefix_consonants
    @prefix_consonants ||=
      first_character(@first_last_name) +
      next_vowel(@first_last_name) +
      first_character(@second_last_name) +
      first_character(valid_first_name)
  end

  def sufix_consonants
    next_consonant(@first_last_name) +
    next_consonant(@second_last_name) +
    next_consonant(valid_first_name)
  end

  def valid_first_name
    valid_second_name? ? @second_name : @first_name
  end

  def valid_second_name?
    COMMON_NAMES.include?(@first_name) && !blank_string?(@second_name)
  end

  def first_character(str)
    return 'X' if blank_string?(str)

    str[0].upcase
  end

  def next_consonant(str)
    return 'X' if blank_string?(str)

    consonants = remove_vowels(str)
    consonants.size.zero? ? 'X' : consonants[0].upcase
  end

  def next_vowel(str)
    return 'X' if blank_string?(str)

    vowels = remove_consonants(str)
    vowels.size.zero? ? 'X' : vowels[0].upcase
  end

  def remove_vowels(str)
    new_str = removing_first_char(str)
    new_str.downcase.tr('aeiou', '')
  end

  def remove_consonants(str)
    new_str = removing_first_char(str)
    new_str.downcase.tr('^aeiou', '')
  end

  def removing_first_char(str)
    str[1..]
  end
end
