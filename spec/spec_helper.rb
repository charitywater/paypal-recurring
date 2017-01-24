require "bundler"
Bundler.setup(:default, :development)
Bundler.require

require "paypal-recurring"
require "vcr"
require "active_support/all"
require 'pry-byebug'
require 'its'
require 'rspec/collection_matchers'

VCR.configure do |config|
  config.cassette_library_dir = File.dirname(__FILE__) + "/fixtures"
  config.hook_into :fakeweb
  config.filter_sensitive_data("<PAYPAL_USERNAME>") { ENV["PAYPAL_USERNAME"] }
  config.filter_sensitive_data("<PAYPAL_PASSWORD>") { ENV["PAYPAL_PASSWORD"] }
  config.filter_sensitive_data("<PAYPAL_SIGNATURE>") { ENV["PAYPAL_SIGNATURE"] }
  config.filter_sensitive_data("<PAYPAL_SELLER_ID>") { ENV["PAYPAL_SELLER_ID"] }
  config.filter_sensitive_data("<PAYPAL_EMAIL>") { ENV["PAYPAL_EMAIL"] }
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  config.before do
    FakeWeb.clean_registry

    PayPal::Recurring.configure do |config|
       config.sandbox = true
       config.username = ENV["PAYPAL_USERNAME"]
       config.password = ENV["PAYPAL_PASSWORD"]
       config.signature = ENV["PAYPAL_SIGNATURE"]
       config.seller_id = ENV["PAYPAL_SELLER_ID"]
       config.email = ENV["PAYPAL_EMAIL"]
    end
  end
end
