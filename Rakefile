require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RSpec::Core::RakeTask.new(:spec) do |task|
  task.rspec_opts = ['--color', '--format', 'progress']
end

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ['lib/**/*.rb']
  # only show the files with failures
  task.formatters = ['files']
  # don't abort rake on failure
  task.fail_on_error = false
end

RuboCop::RakeTask.new do |task|
  task.requires << 'rubocop-rspec'
end

desc 'Run RSpec with code coverage'
task :coverage do
  Rake::Task['spec'].execute
  `rake spec COVERAGE=true`
  `open coverage/index.html`
end

task default: :spec
