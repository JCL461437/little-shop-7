require "rails_helper"

RSpec.describe "Items Edit/Update Page" do
  
  describe "As a Merchant" do
    describe "When I visit the items show page" do
      it "I can edit the item" do
        merchant = Merchant.create!(name: "Acme")
        item = merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
        
        visit "/merchants/#{merchant.id}/items/#{item.id}"
      
        click_on("Update Item")
        
        expect(page).to have_field("Name", with: "Candle")
        expect(page).to have_field("Description", with: "Pine Scented")
        expect(page).to have_field("Unit price", with: (1000))

        expect(current_path).to eq "/merchants/#{merchant.id}/items/#{item.id}/edit"
        
        fill_in "Name", with: "Oceanfront Resort Candle"
        fill_in "Description", with: "Driftwood and Ocean Breeze"
        fill_in "Unit price", with: (3000)
      
        click_button "Update Item"
       
        expect(current_path).to eq "/merchants/#{merchant.id}/items/#{item.id}"
        
        expect(page).to have_content("Oceanfront Resort Candle")
        expect(page).to have_content("Driftwood and Ocean Breeze")
        expect(page).to have_content("30.00")
        expect(page).to have_content("Update Item")
      end
    end
  end
end