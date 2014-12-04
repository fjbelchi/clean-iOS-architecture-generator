guard 'rspec', cmd: 'rspec --color --format doc'  do
  # watch /lib/ files
  watch(/^lib\/(.+)\.rb$/) do |m|
    "spec/#{m[1]}_spec.rb"
  end

  # watch /spec/ files
  watch(/^spec\/(.+)\.rb$/) do |m|
    "spec/#{m[1]}.rb"
  end
end

guard :rubocop do
  watch(/.+\\.rb$/)
  watch(/(?:.+\/)?\.rubocop\.yml$/) { |m| File.dirname(m[0]) }
end
