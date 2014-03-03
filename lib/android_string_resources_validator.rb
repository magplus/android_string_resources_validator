require "android_string_resources_validator/version"
require 'nokogiri'

class AndroidStringResourcesValidator
  def initialize(string)
    @string = string
  end

  def valid?
    errors.empty?
  end

  def errors
    strings.map(&:error).compact
  end

  private

  attr_reader :string

  def strings
    doc.xpath('//resources/string').map do |element|
      ElementString.new(element.text)
    end
  end

  def doc
    Nokogiri::XML(@string)
  end

  class ElementString
    def initialize(string)
      @string = string
    end

    def error
      return "Apostrophes must be escaped" if unsurrounded_contains_unescaped_single_quotes
      return "Double quotes must be escaped" if unsurrounded_contains_unescaped_double_quotes
      return "Double quotes must be escaped or surrounded by single quotes" if string_without_double_quotes_contains_unescaped_double_quotes
      return "Single quotes must be escaped or surrounded by double quotes" if string_without_single_quotes_contains_unescaped_single_quotes
    end

    def unsurrounded_contains_unescaped_single_quotes
      !surrounded_by_double_quotes && !surrounded_by_single_quotes && contains_unescaped_single_quotes
    end

    def unsurrounded_contains_unescaped_double_quotes
      !surrounded_by_double_quotes && !surrounded_by_single_quotes && contains_unescaped_double_quotes
    end

    def surrounded_by_double_quotes
      @string[/\A".*"\z/]
    end

    def contains_unescaped_single_quotes
      @string[/[^\\]'/]
    end

    def surrounded_by_single_quotes
      @string[/\A'.*'\z/]
    end

    def contains_unescaped_double_quotes
      @string[/[^\\]"/]
    end

    def string_without_single_quotes_contains_unescaped_single_quotes
      @string[/\A'.*[^\\]'.*'\z/]
    end

    def string_without_double_quotes_contains_unescaped_double_quotes
      @string[/\A".*[^\\]".*"\z/]
    end
  end
end
