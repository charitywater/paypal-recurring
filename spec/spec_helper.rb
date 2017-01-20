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
end

RSpec.configure do |config|
  config.extend VCR::RSpec::Macros

  config.before do
    FakeWeb.clean_registry

    PayPal::Recurring.configure do |config|
       config.sandbox = true
       config.username = "cwsite_1319565654_biz_api1.gmail.com"
       config.password = "1319565691"
       config.signature = "AIDlgRrr6gKAPoeuzTuFOtK4INGJA3zNHwFL5o1gdsBGQg048aTTj.7W"
       config.seller_id = "8PQPEHCYC73TS"
       config.email = "cwsite_1319565654_biz.gmail.com"
    end
  end
end
