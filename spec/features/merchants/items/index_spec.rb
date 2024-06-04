require "rails_helper"

RSpec.describe "Merchant Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant2.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
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
        save_and_open_page
        expect(page).to have_content("My Items")
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end
  end
# User Story 9 - Merchant Item Disable/Enable
# As a merchant
# When I visit my items index page (/merchants/:merchant_id/items)
# Next to each item name I see a button to disable or enable that item.
# When I click this button
# Then I am redirected back to the items index
# And I see that the items status has changed
  describe "As a Merchant" do
  end
end