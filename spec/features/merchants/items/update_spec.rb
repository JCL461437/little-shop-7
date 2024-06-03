require "rails_helper"

RSpec.describe "Items Edit/Update Page" do
  before(:each) do
    @merchant = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
  end

# User Story 8 - Merchant Item Update
# As a merchant,
# When I visit the merchant show page of an item (/merchants/:merchant_id/items/:item_id)
# I see a link to update the item information.
# When I click the link
# Then I am taken to a page to edit this item
# And I see a form filled in with the existing item attribute information
# When I update the information in the form and I click ‘submit’
# Then I am redirected back to the item show page where I see the updated information
# And I see a flash message stating that the information has been successfully updated.
  
  describe "As a Merchant" do
    describe "When I visit the items show page" do
      it "I can edit the item" do
        visit "/merchants/#{@merchant.id}/items/#{@item.id}"
      
        click_on("Update Item")
        
        expect(page).to have_field("Name", with: "Candle")
        expect(page).to have_field("Description", with: "Pine Scented")
        expect(page).to have_field("Unit price", with: (1000))

        expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
        
        fill_in "Name", with: "Oceanfront Resort Candle"
        fill_in "Description", with: "Driftwood and Ocean Breeze"
        fill_in "Unit price", with: (3000)
      
        click_button "Update Item"

        expect(current_path).to eq "/merchants/#{@merchant.id}/items/#{@item.id}"
        
        expect(page).to have_content("Oceanfront Resort Candle")
        expect(page).to have_content("Driftwood and Ocean Breeze")
        expect(page).to have_content("30.00")
        expect(page).to have_content("Update Item")
      end
    end
  end
end