# -*- encoding: utf-8 -*-

require 'rubygems'
require 'bundler'
include Rake::DSL
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = "github-api-client"
  gem.homepage = "http://github.com/okonski/github-api-client"
  gem.license = "MIT"
  gem.summary = %Q{Library for easy GitHub API browsing}
  gem.description = %Q{Caches retrieved information to your user profile and reuses it when you query again.}
  gem.email = "kuba@okonski.org"
  gem.authors = ["Jakub Okoński"]
  
  gem.files = [Dir.glob('lib/**/*'), Dir.glob('db/**/*'), 'VERSION', 'Gemfile', 'Gemfile.lock']
  gem.executables = ['api-browser.rb']
  
  gem.test_files = [Dir.glob('features/**/*'), Dir.glob('spec/**/*')]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
