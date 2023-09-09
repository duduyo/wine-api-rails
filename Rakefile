# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

Rails.application.load_tasks

task :'test:all' do
  Rake::Task['test:all'].invoke
  Rake::Task['spec'].invoke
end

task :build do
  Rake::Task['test:all'].invoke
  Rake::Task['rswag'].invoke
end