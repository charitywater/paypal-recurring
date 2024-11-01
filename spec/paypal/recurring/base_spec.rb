require 'spec_helper'

describe PayPal::Recurring::Base do
  describe '#checkout' do
    let(:request) { double(:request) }

    before do
      allow(PayPal::Recurring::Request).to receive(:new).and_return(request)
      allow(request).to receive(:run)
    end

    it 'sets a default value for no_shipping' do
      PayPal::Recurring::Base.new.checkout
      expect(request).to have_received(:run).with(:checkout, hash_including(no_shipping: 0))
    end

    it 'passes the no_shipping value when provided' do
      PayPal::Recurring::Base.new(no_shipping: 1).checkout
      expect(request).to have_received(:run).with(:checkout, hash_including(no_shipping: 1))
    end
  end
end
