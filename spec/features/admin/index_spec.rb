require 'rails_helper'

RSpec.describe 'admin index' do

  describe 'As an admin, when I visit the admin dashboard' do
    it 'displays a header indicating that I am on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
      expect(page).to have_link("Dashboard")
    end

    it 'displays a link to the admin merchants and invoices indicies' do 
      visit "/admin"
      
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Invoices")
    end
  end

end