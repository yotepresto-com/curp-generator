require 'curp'

class CurpGenerator::Base
  include CurpGenerator::Catalogs

  InvalidCurpArgumentError = Class.new(StandardError)

  def generate
    raise NotImplementedError
  end

  private

  def valid_params?
    raise NotImplementedError
  end

  def error_message!
    raise NotImplementedError
  end

  def parse_attribute(attribute)
    return if blank_string?(attribute)

    str = remove_special_chars(normalize(attribute))
    remove_composed_names(str)
  end

  def blank_string?(value)
    value.to_s.strip.empty?
  end

  def remove_special_chars(string)
    string&.gsub(/[.'\d-]/, "")
  end

  def normalize(string)
    string&.tr(
      "ÀàÁáÄäÈèÉéËëÌìÍíÏïÒòÓóÖöÙùÚúÜüÑñ",
      "AaAaAaEeEeEeIiIiIiOoOoOoUuUuUuXx"
    )
  end

  def remove_composed_names(name)
    name = name.upcase

    COMPOSED_NAMES.each do |composed|
      next unless name.include?(composed)

      name = name.gsub(composed, '')
    end
    name
  end
end
