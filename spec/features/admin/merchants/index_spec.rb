require 'rails_helper'

RSpec.describe "admin merchants index" do

  describe "As an admin when I visit the admin merchants index (/admin/merchants)" do
    describe "display" do
      it "I see the name of each merchant in the system" do
        merchants = FactoryBot.create_list(:merchant, 10)

        visit admin_merchants_path
        
        merchants.each do |merchant|
          expect(page).to have_content(merchant.name)
        end
      end
    end

    describe "When I click on the name of a merchant" do
      it "I am taken to (/admin/merchants/:merchant_id) and see merchant's name" do
        merchant_1 = Merchant.create!(name: "Acme")
        merchant_2 = Merchant.create!(name: "BigBox")
        
        visit admin_merchants_path

        click_link("#{merchant_1.name}")

        expect(current_path).to eq(admin_merchant_path(merchant_1))
        expect(page).to have_content("Acme")
        expect(page).to_not have_content("BigBox")
      end
    end
  end
end
