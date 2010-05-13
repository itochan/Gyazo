# encoding: utf-8

require "#{File.dirname(__FILE__)}/upload.rb"
use Rack::ShowExceptions

run Upload.new

