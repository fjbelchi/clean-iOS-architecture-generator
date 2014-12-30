# CLI for generator
class IOSGenThor < Thor
  include Thor::Actions

  def self.source_root
    File.dirname(__FILE__)
  end

  desc 'generate', 'Generate new code with spec file'
  option :test, aliases: '-t', desc: 'Generate unit tests'
  # method_option :languague, aliases: '-l', desc: 'objc or swift'
  def generate(file_path)
    puts file_path
    generator = IOSGen::Generator::BaseGenerator.new(file_spec: file_path)
    generator.generate
    generator.generate_test if options[:test]
  end
end
