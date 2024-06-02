require "rails_helper"

RSpec.describe "Items Show Page" do
  before(:each) do
    @merchant = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
  end
# User Story 7 - Merchant Items Show Page
# As a merchant
# When I click on the name of an item from the merchant items index page, (merchants/:merchant_id/items)
# Then I am taken to that merchant's item's show page (/merchants/:merchant_id/items/:item_id)
# And I see all of the item's attributes including:
# Name
# Description
# Current Selling Price
  describe "As a Merchant" do
    describe "When I visit the items show page" do
      it "I see the selected items attributes" do
        visit "/merchants/#{@merchant.id}/items"

        click_on("Candle")

        expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item.id}"

        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item.description)
        expect(page).to have_content("$10.00")

        expect(page).to_not have_content(@item2.name)
        expect(page).to_not have_content(@item2.description)
        expect(page).to_not have_content(@item2.unit_price)

        expect(page).to_not have_content(@item3.name)
        expect(page).to_not have_content(@item3.description)
        expect(page).to_not have_content(@item3.unit_price)
      end
    end
  end
end