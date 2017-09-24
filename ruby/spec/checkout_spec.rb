require_relative '../lib/checkout'

RSpec.describe Checkout do
  subject { described_class.new(PricingRules) }
  context '#scan' do
    it 'raises InvalidProductCode if no product exists with that code' do
      expect {
        subject.scan('TEDDY_BEAR')
      }.to raise_error(Checkout::InvalidProductCode)
    end

    it 'adds to the cart if product exists' do
      expect(subject.cart).to receive(:add)
      subject.scan('VOUCHER')
    end
  end

  describe '#total' do
    context 'example 1' do
      before do
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('MUG')
      end

      it 'returns total price' do
        expect(subject.total).to eq 32.5
      end
    end

    context 'example 2' do
      before do
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
      end

      it 'returns total price' do
        expect(subject.total).to eq 25.0
      end
    end

    context 'example 3' do
      before do
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
      end

      it 'returns total price' do
        expect(subject.total).to eq 81.0
      end
    end

    context 'example 4' do
      before do
        subject.scan('VOUCHER')
        subject.scan('TSHIRT')
        subject.scan('VOUCHER')
        subject.scan('VOUCHER')
        subject.scan('MUG')
        subject.scan('TSHIRT')
        subject.scan('TSHIRT')
      end

      it 'returns total price' do
        expect(subject.total).to eq 74.5
      end
    end
  end

end
