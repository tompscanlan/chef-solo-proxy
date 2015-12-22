#!/usr/bin/env rake

require 'rake'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Runs foodcritic linter'
  task :foodcritic do
    if Gem::Version.new('1.9.2') <= Gem::Version.new(RUBY_VERSION.dup)
      sandbox = File.join(File.dirname(__FILE__), %w(tmp foodcritic cookbook))
      prepare_foodcritic_sandbox(sandbox)

      sh "foodcritic --epic-fail any #{File.dirname(sandbox)}"
    else
      puts "WARN: foodcritic run is skipped as Ruby #{RUBY_VERSION} is < 1.9.2."
    end
  end
  def prepare_foodcritic_sandbox(sandbox)
    files = %w(*.md *.rb attributes definitions
               files libraries providers recipes resources templates)

    rm_rf sandbox
    mkdir_p sandbox
    cp_r Dir.glob("{#{files.join(',')}}"), sandbox
    puts "\n\n"
  end

  desc 'Run Chef style checks'
  Rake::Task['foodcritic'].execute
end

desc 'Run all style checks'
task style: ['style:ruby', 'style:foodcritic']

desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.pattern = './**/unit/**/*_spec.rb'
end

desc 'Run Test Kitchen'
task :integration do
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

# Default
task default: %w(style unit)

task full: %w(style unit integration)
