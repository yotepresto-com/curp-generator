# frozen_string_literal: true

class CurpGenerator::StringFormat

  attr_accessor :str

  def initialize(str)
    @str = remove_special_chars(normalize(str.strip))
  end

  def remove_vowels
    str.downcase.tr('aeiou', '')
  end

  def remove_consonants
    str.downcase.tr('^aeiou', '')
  end

  def vowel?
    %w(A E I O U).include?(str.upcase)
  end

  def consonant?
    !vowel?
  end

  def first_vowel
    str.downcase.match(/a|e|i|o|u/).to_s.upcase
  end

  private

  def normalize(string)
    string&.tr(
      "ÀàÁáÄäÈèÉéËëÌìÍíÏïÒòÓóÖöÙùÚúÜüÑñ",
      "AaAaAaEeEeEeIiIiIiOoOoOoUuUuUuNn"
    )
  end

  def remove_special_chars(string)
    string&.gsub(/[\.\'\d-]/, "")
  end
end
