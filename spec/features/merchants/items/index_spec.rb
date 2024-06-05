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
    describe "When I visit the merchant items index" do
      it "I see a list of only my items names" do
        visit "/merchants/#{@merchant.id}/items"

        expect(page).to have_content("My Items")
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end
  end

  describe "As a Merchant" do
    it "There is a button to disable/enable the item" do
      visit "/merchants/#{@merchant.id}/items"
    
      within "#disabled_item_#{@item.id}" do
        click_on("Enable")
      end

      expect(current_path).to eq "/merchants/#{@merchant.id}/items"
      expect(page).to have_content("Disable")
    end
  end
end