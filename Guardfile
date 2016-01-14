guard :minitest do
  # with Minitest::Unit
  watch(%r{^test/(.*)\/?(.*)_test\.rb$}) { 'test' }
  watch(%r{^lib/(.*/)?([^/]+)\.rb$})     { |m| "test/#{m[1]}test_#{m[2]}.rb" }
  watch(%r{^test/test_helper\.rb$})      { 'test' }

  watch(%r{^lib/(.*)\.rb$}) { |m| "test/#{m[1]}_test.rb" }
end
