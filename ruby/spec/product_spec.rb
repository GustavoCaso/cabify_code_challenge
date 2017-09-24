require_relative '../lib/product'

RSpec.describe Product do
  subject { described_class.new('CAR', 'The new fancy car', 1.00) }

  it '#code' do
    expect(subject.code).to eq 'CAR'
  end

  it '#name' do
    expect(subject.name).to eq 'The new fancy car'
  end

  it '#price' do
    expect(subject.price).to eq 1.00
  end
end
