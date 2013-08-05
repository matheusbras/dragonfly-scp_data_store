require 'rubygems'
require 'bundler'
require 'active_support/inflector'
Bundler.setup(:default, :test)

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'dragonfly/scp_data_store'

def test_app
  Dragonfly::App.send(:new)
end