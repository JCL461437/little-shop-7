require "rails_helper"

RSpec.describe "Merchant Show Page" do
  before(:each) do
    @merchant = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
  end
# User Story 6 - Merchant Items Index Page
# As a merchant,
# When I visit my merchant items index page (merchants/:merchant_id/items)
# I see a list of the names of all of my items
# And I do not see items for any other merchant
  describe "As a Merchant" do
    describe "When I visit the merchant items index" do
      it "I see a list of only my items names" do
        visit "/merchants/#{@merchant.id}/items"
        
        expect(page).to have_content("My Items")
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item3.name)
      end
    end
  end
end