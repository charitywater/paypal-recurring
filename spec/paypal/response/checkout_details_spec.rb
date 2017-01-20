require 'spec_helper'

describe PayPal::Recurring::Response::Details do
  context "when successful" do
    use_vcr_cassette("details/success")

    subject {
      ppr = PayPal::Recurring.new(:token => "EC-16942802DK365081S")
      ppr.checkout_details
    }

    it { should be_valid }
    it { should be_success }

    its(:errors) { should be_empty }
    its(:status) { should == "PaymentActionNotInitiated" }
    its(:email) { should == "maji-test-buyer@charitywater.org" }
    its(:requested_at) { should be_a(Time) }
    its(:payer_id) { should == "KV8YLGHNPVT8Q" }
    its(:payer_status) { should == "verified" }
    its(:country) { should == "US" }
    its(:currency) { should == "USD" }
    its(:description) { should == "Monthly Giving" }
    its(:ipn_url) { should be nil }
    its(:agreed?) { should be true }
    its(:postal_code) { should == "95131" }
  end

  context "when cancelled" do
    use_vcr_cassette "details/cancelled"
    subject {
      ppr = PayPal::Recurring.new(:token => "EC-8J298813NS092694P")
      ppr.checkout_details
    }

    it { should be_valid }
    it { should be_success }

    its(:agreed?) { should be false }
  end

  context "when failure" do
    use_vcr_cassette("details/failure")
    subject { PayPal::Recurring.new.checkout_details }

    it { should_not be_valid }
    it { should_not be_success }

    its(:errors) { should have(1).item }
  end
end
