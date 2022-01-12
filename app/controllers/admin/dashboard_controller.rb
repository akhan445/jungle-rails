class Admin::DashboardController < ApplicationController
  def show
    @categories = Category.select("name")
    @quantities = Product.sum("quantity")
    @products = Product.all
  end
end
