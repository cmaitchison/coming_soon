# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'jasmine' do
  watch(%r{app/assets/javascripts/(.+)\.(js\.coffee)$}) { |m| "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{spec/javascripts/(.+)_spec\.(js\.coffee)$})  { |m| puts m.inspect; "spec/javascripts/#{m[1]}_spec.#{m[2]}" }
  watch(%r{spec/javascripts/spec\.(js\.coffee)$})       { "spec/javascripts" }
end
