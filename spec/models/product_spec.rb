require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "saves successfully with all fields set" do
      category = Category.create(name: "Exotic Plants")
      product = Product.new(
        name: "Tiger plant",
        quantity: 50,
        price_cents: 1222,
        category: category
      )
      expect(product.save).to be true
    end

    it "requires name to be present" do 
      category = Category.create(name: "Exotic Plants")
      product = Product.new(
        name: nil,
        quantity: 50,
        price_cents: 1222,
        category: category
      )
      product.valid?
      expect(product.errors[:name]).to_not be_empty
    end

    it "requires quantity to be present" do 
      category = Category.create(name: "Exotic Plants")
      product = Product.new(
        name: 'Tiger plant',
        quantity: nil,
        price_cents: 1222,
        category: category
      )
      product.valid?
      expect(product.errors[:quantity]).to_not be_empty
    end

    it "requires price to be present" do 
      category = Category.create(name: "Exotic Plants")
      product = Product.new(
        name: 'Tiger plant',
        quantity: 50,
        price_cents: nil,
        category: category
      )
      product.valid?
      expect(product.errors[:price]).to_not be_empty
    end

    it "requires category to be present" do 
      product = Product.new(
        name: 'Tiger plant',
        quantity: 50,
        price_cents: 1222,
        category: nil
      )
      product.valid?
      expect(product.errors[:category]).to_not be_empty
    end
  end
end

