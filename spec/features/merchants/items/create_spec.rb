require "rails_helper"

RSpec.describe "Merchant Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant2.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
  end
  
  describe "As a Merchant" do
    describe "When I visit the items index page and click the link to create a new item" do
      it "I can fill out a form and add a new item to my list of items" do 
        visit "/merchants/#{@merchant.id}/items"

        click_on "New Item"

        expect(current_path).to eq "/merchants/#{@merchant.id}/items/new"
       
        fill_in "Name", with: "Leather Jacket"
        fill_in "Description", with: "Comfy AND Stylish"
        fill_in "Unit price", with: (5000)
        click_button "Save"

        expect(current_path).to eq "/merchants/#{@merchant.id}/items"
              
        expect(page).to have_content("Leather Jacket")
        expect(page).to have_content("Enable")
      end
    end
  end
end
