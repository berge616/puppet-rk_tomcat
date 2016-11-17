require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera'

RSpec.configure do |c|
  c.hiera_config = 'spec/fixtures/hiera/hiera.yaml'
  c.parser = 'future' if Puppet.version.to_f >= 4.0
  c.environmentpath = File.expand_path(File.join(Dir.pwd, 'spec')) if Puppet.version.to_f >= 4.0
end
