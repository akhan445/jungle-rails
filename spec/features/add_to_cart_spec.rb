require 'rails_helper'

RSpec.feature "Visitor adding item to cart", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They visit the home page and click add on a product, which adds item to their cart" do
  # ACT
  visit root_path

  page.find('article.product', match: :first).click_button 'Add'

  # DEBUG
  # save_and_open_screenshot

  # VERIFY
  within('nav') { expect(page).to have_content("My Cart (1)") }
  end

end