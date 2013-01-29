require 'rubygems'
require "bundler/setup"
require 'minitest/autorun'

require File.join(File.dirname(__FILE__), '../lib/submarine')

unless File.exists?(File.join(File.dirname(__FILE__), 'classifiers/my_submarine.classifier'))
  require File.join(File.dirname(__FILE__), 'train')
end
require File.join(File.dirname(__FILE__), 'my_submarine')