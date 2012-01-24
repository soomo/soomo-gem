require "bundler/gem_tasks"

task(:test) {
  root = File.dirname(__FILE__)
  test = File.join(root, 'test')

  $: << File.join(root, 'lib')
  $: << test

  require 'soomo'

  require "#{test}/test_helper.rb"
  Dir["#{test}/**/test_*.rb"].each {|file| require(file) }
}
