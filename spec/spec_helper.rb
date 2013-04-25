# Copyright (c) 2012-2013 Stark & Wayne, LLC

ENV["BUNDLE_GEMFILE"] ||= File.expand_path("../../Gemfile", __FILE__)

require "rubygems"
require "bundler"
Bundler.setup(:default, :test)

$:.unshift(File.expand_path("../../lib", __FILE__))

require "rspec/core"
require "fakeweb"

# for the #sh helper
require "rake"
require "rake/file_utils"

require "jenkins_test_harness"
require "jenkins_job"

Dir[File.dirname(__FILE__) + '/support/*'].each{|path| require path}

def spec_asset(filename)
  File.expand_path("../assets/#{filename}", __FILE__)
end

RSpec.configure do |c|
  c.before(:each) do

  end
end
