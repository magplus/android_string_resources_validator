# AndroidStringResourcesValidator

Validates an Android strings.xml resource file against the specification at
http://developer.android.com/guide/topics/resources/string-resource.html

## Installation

Add this line to your application's Gemfile:

    gem 'android_string_resources_validator'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install android_string_resources_validator

## Usage

```ruby
strings_xml = %q{<resources><string name="hello">It\'s all right</string></resources>}
validator = AndroidStringResourcesValidator.new(strings_xml)
validator.valid? # => true

strings_xml = %q{<resources><string name="hello">It's no good</string></resources>}
validator = AndroidStringResourcesValidator.new(strings_xml)
validator.valid? # => false
validator.errors # => ["Apostrophes must be escaped"]

strings_xml = %q{<foo><string name="string_name">text_string</string></foo>}
validator = AndroidStringResourcesValidator.new(strings_xml)
validator.valid? # => false
validator.errors # => ["Not a string resource document"]

strings_xml = %q{<foo>}
validator = AndroidStringResourcesValidator.new(strings_xml)
validator.valid? # => false
validator.errors # => ["Not a valid XML document"]
```

## Contributing

1. Fork it ( http://github.com/<my-github-username>/android_string_resources_validator/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
