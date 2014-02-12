require 'android_string_resources_validator'

describe AndroidStringResourcesValidator do
  specify %q{"This'll work"} do
    string = %q{"This'll work"}
    validator = AndroidStringResourcesValidator.new(string)
    validator.should be_valid
    validator.errors.should be_empty
  end

  specify %q{This\'ll also work} do
    string = %q{This\'ll also work}
    validator = AndroidStringResourcesValidator.new(string)
    validator.should be_valid
    validator.errors.should be_empty
  end

  specify %q{This doesn't work} do
    string = %q{This doesn't work}
    validator = AndroidStringResourcesValidator.new(string)
    validator.should_not be_valid
    validator.errors.should == ["Apostrophes must be escaped"]
  end

  specify %q{XML encodings don&apos;t work} do
    string = %q{XML encodings don&apos;t work}
    validator = AndroidStringResourcesValidator.new(string)
    validator.errors.should == ["XML encodings don't work"]
  end
end
