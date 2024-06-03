require 'rails_helper'

RSpec.describe "admin merchants index" do

  describe "As an admin when I visit the admin merchants index (/admin/merchants)" do
    it "I see the name of each merchant in the system" do
      merchants = FactoryBot.create_list(:merchant, 10)

      visit admin_merchants_path
      
      merchants.each do |merchant|
        expect(page).to have_content(merchant.name)
      end
    end
  end
end
