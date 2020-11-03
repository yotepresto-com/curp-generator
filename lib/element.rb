require 'helpers'
require 'string_format'

class CurpGenerator::Element
  include CurpGenerator::Helpers

  attr_accessor :name, :consonant_index, :vowel_index

  def initialize(name)
    @name = name
    @consonant_index = 0
    @vowel_index = 0
  end

  def first_character
    return 'X' if blank_string?(name)

    character = name[0].upcase
    update_next_index_attribute(character)
    character == 'Ñ' ? 'X' : character
  end

  def next_consonant
    return 'X' if blank_string?(name)

    consonants = CurpGenerator::StringFormat.new(name).remove_vowels.upcase
    consonants.size < 2 ? consonants[0] : consonants[consonant_index]
  end

  def next_vowel
    return 'X' if blank_string?(name)

    consonants = CurpGenerator::StringFormat.new(name).remove_consonants.upcase
    consonants.size < 2 ? 'X' : consonants[vowel_index]
  end

  private

  def update_next_index_attribute(character)
    new_consonant_value = CurpGenerator::StringFormat.new(character).consonant? ? 1 : 0
    new_vowel_value = CurpGenerator::StringFormat.new(character).vowel? ? 1 : 0
    self.consonant_index = new_consonant_value
    self.vowel_index = new_vowel_value
  end
end
