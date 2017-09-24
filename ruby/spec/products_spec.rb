require_relative '../lib/products'

RSpec.describe Products do
  subject { described_class }
  context 'No file found' do
    it 'raises NoProductsFile' do
      expect {
        subject.load('../../no_file')
      }.to raise_error(Products::NoProductsFile)
    end
  end

  context 'Invalid file format' do
    it 'raises InvalidProductFileFormat if missing products key' do
      expect {
        subject.load('../../spec/fixtures/no_products_key')
      }.to raise_error(Products::InvalidProductFileFormat)
    end

    it 'raises InvalidProductFileFormat if a product have invalid keys' do
      expect {
        subject.load('../../spec/fixtures/invalid_product_key')
      }.to raise_error(Products::InvalidProductFileFormat)
    end
  end

  context 'Correct file' do
    it 'returns a list of Products' do
      products = subject.load('../../spec/fixtures/valid_products')
      expect(products.first).to be_a(Product)
    end
  end
end
