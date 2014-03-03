require 'android_string_resources_validator'

describe AndroidStringResourcesValidator do
  specify %q{"This'll work"} do
    assert_valid %q{"This'll work"}
  end

  specify %q{This\'ll also work} do
    assert_valid %q{This\'ll also work}
  end

  specify %q{This doesn't work} do
    assert_invalid %q{This doesn't work}, "Apostrophes must be escaped"
  end

  specify %q{'A lonely " seems weird, but is allowed'} do
    assert_valid %q{'A lonely " seems weird, but is allowed'}
  end

  specify %q{A lonely \" seems weird, but is allowed} do
    assert_valid %q{A lonely \" seems weird, but is allowed}
  end

  specify %q{A lonely " is not allowed} do
    assert_invalid %q{A lonely " is not allowed}, "Double quotes must be escaped"
  end

  specify %q{"A lonely " is not allowed"} do
    assert_invalid %q{"A lonely " is not allowed"}, "Double quotes must be escaped or surrounded by single quotes"
  end

  specify %q{'A lonely ' is not allowed'} do
    assert_invalid %q{'A lonely ' is not allowed'}, "Single quotes must be escaped or surrounded by double quotes"
  end

  specify %q{Special identifiers such as %&amp; and %d are allowed} do
    assert_valid %q{Special identifiers such as %&amp; and %d are allowed}
  end

  specify "Requires valid XML" do
    invalid_xml = strings_xml('whatever').chop
    validator = AndroidStringResourcesValidator.new(invalid_xml)
    validator.errors.should == ["Not a valid XML document"]
    validator.should_not be_valid
  end

  specify "Requires a string resources document" do
    unknown_xml = %q{<foo><string name="ciao">I have no idea what XML this is!<resources>Who knows?</resources></string></foo>}
    validator = AndroidStringResourcesValidator.new(unknown_xml)
    validator.errors.should == ["Not a string resource document"]
    validator.should_not be_valid
  end

  private

  def strings_xml(string)
    %Q{<resources><string name="hello">#{string}</string></resources>}
  end

  def assert_valid(string)
    validator = AndroidStringResourcesValidator.new(strings_xml(string))
    validator.errors.should == []
    validator.should be_valid
  end

  def assert_invalid(string, error_message)
    validator = AndroidStringResourcesValidator.new(strings_xml(string))
    validator.should_not be_valid
    validator.errors.should == Array(error_message)
  end
end
