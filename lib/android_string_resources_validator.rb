require "android_string_resources_validator/version"

class AndroidStringResourcesValidator
  def initialize(string)
    @string = string
  end

  def valid?
  end

  def errors
    []
  end

  private

  attr_reader :string
end
