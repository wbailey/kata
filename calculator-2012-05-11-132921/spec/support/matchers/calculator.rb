RSpec::Matchers.define :your_method do |expected|
  match do |your_match|
    #your_match.method_on_object_to_execute == expected
  end
end
