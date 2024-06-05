require 'rails_helper'

RSpec.describe "admin merchants show" do
  describe "As an admin when I visit /admin/merchants/:merchant_id" do
    describe "display" do
      it "I see a link to update the merchant's information" do
        merchant_1 = Merchant.create!(name: "Acme")

        visit admin_merchant_path(merchant_1)

        expect(page).to have_link("Update Merchant")
      end
    
      #Could move this all over to a admin/merchant/edit_spec (if we want to make one)
      it "the link takes me to a page to edit this merchant and I see a form filled in with the merchant info" do
        merchant_1 = Merchant.create!(name: "Acme")
        
        visit admin_merchant_path(merchant_1)

        click_link("Update Merchant")

        expect(current_path).to eq(edit_admin_merchant_path(merchant_1))
        expect(page).to have_field("Name", with: "Acme")
      end

      it "when I update the form and click 'submit' I am redirected to /admin/merchants/:merchant_id and see updated info and flash message of successful update" do
        merchant_1 = Merchant.create!(name: "Acme")
        
        visit edit_admin_merchant_path(merchant_1)

        fill_in "Name", with: "Acme Inc."

        click_button "submit"
        
        expect(current_path).to eq(admin_merchant_path(merchant_1))
        expect(page).to have_content("Acme Inc.")
        expect(page).to have_content("Information has been successfully updated")
      end
    end

  end

end