require "rails_helper"

RSpec.describe "Merchant Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant2.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
  end
  # User Story 11 - Merchant Item Create
  # As a merchant
  # When I visit my items index page
  # I see a link to create a new item.
  # When I click on the link,
  # I am taken to a form that allows me to add item information.
  # When I fill out the form I click ‘Submit’
  # Then I am taken back to the items index page
  # And I see the item I just created displayed in the list of items.
  # And I see my item was created with a default status of disabled.
  describe "As a Merchant" do
    describe "When I visit the items index page and click the link to create a new item" do
      it "I can fill out a form and add a new item to my list of items"
      visit "/merchants/#{@merchant.id}/items"

      click_on "New Item"

      expect(current_path).to eq "/merchants/#{@merchant.id}/items/new"
      
      fill_in "Name", with: "Leather Jacket"
      fill_in "Description", with: "Comfy AND Stylish"
      fill_in "Unit Price", with: (5000)
      click_button "Submit"

      expect(current_path).to eq "/merchants/#{@merchant.id}/items"

      expect(page).to have_content("Leather Jacket")
      expect(page).to have_content("Comfy AND Stylish")
      expect(page).to have_content("50.00")
    end
  end
end
