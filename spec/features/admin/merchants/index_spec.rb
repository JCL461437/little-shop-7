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

    describe "I see a button to disable or enable that merchant" do
      # As an admin,
      # When I visit the admin merchants index (/admin/merchants)
      # Then next to each merchant name I see a button to disable or enable that merchant.
      # When I click this button
      # Then I am redirected back to the admin merchants index
      # And I see that the merchant's status has changed
      it "Displays a button that can change a merchant's status" do
        merchant_1 = Merchant.create!(name: "Mans Machines", status: 1, id: 500)
        merchant_2 = Merchant.create!(name: "Guys Gizzmos", status: 1, id: 501)
        merchant_3 = Merchant.create!(name: "Weasels Wallets", status: 0, id: 502)

        visit admin_merchants_path

        within ('#enabled_merchants') do
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content(merchant_2.name)
        end
      
        within ('#disabled_merchants') do
          expect(page).to have_content(merchant_3.name)
        end

        within ('#disabled_merchant_502') do
          click_button 'Enable'
        end
        
        within ('#enabled_merchants') do
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content(merchant_2.name)
          expect(page).to have_content(merchant_3.name)
        end

        within ('#enabled_merchant_502') do
          click_button 'Disable'
        end

        within ('#disabled_merchants') do
          expect(page).to have_content(merchant_3.name)
        end

      end
    end
  end
end
