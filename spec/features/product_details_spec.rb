require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product details page", type: :feature, js: true do

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

  scenario "They click on a product header on home page which redirects to product page" do
    # ACT
    visit root_path

    product_page_link = page.find('article.product > header > a', match: :first)['href']

    page.find('article.product > header', match: :first).click

    sleep 1

    # DEBUG
    # save_and_open_screenshot

    # VERIFY
    assert_current_path(product_page_link)
  end
end