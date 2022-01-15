require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:example) do
      @category = Category.new(name: "Kitchen")
    end

    it "is valid with all fields set" do
      @product = Product.new(
        name: "Knife",
        price: 10000,
        quantity: 20,
        category: @category
      )
      expect(@product).to be_valid
    end

    it "is not valid without name field" do
      @product = Product.new(
        name: nil,
        price: 10000,
        quantity: 20,
        category: @category
      )
      expect(@product).to_not be_valid
    end

    it "is not valid without price field" do
      @product = Product.new(
        name: "Knife",
        price: nil,
        quantity: 20,
        category: @category
      )
      expect(@product).to_not be_valid
    end

    it "is not valid without quantity field" do
      @product = Product.new(
        name: "Knife",
        price: 10000,
        quantity: nil,
        category: @category
      )
      expect(@product).to_not be_valid
    end

    it "is not valid without category field" do
      @product = Product.new(
        name: "Knife",
        price: 10000,
        quantity: 20,
        category: nil
      )
      expect(@product).to_not be_valid
    end

  end

end
