require "rails_helper"

RSpec.describe "Merchant Invoices Index Page" do
  describe "as a Merchant" do
    scenario "I see all of the invoices that include at least one of my merchant's items, each invoice has an ID that is linked to its merchant invoice show page" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice1 = create(:invoice, customer: customer)
      invoice2 = create(:invoice, customer: customer)
      create(:invoice_item, invoice: invoice1, item: item)
      create(:invoice_item, invoice: invoice2, item: item)

      visit merchant_invoices_path(merchant)

      expect(page).to have_link(invoice1.id)
      expect(page).to have_link(invoice2.id)
    end
  end
end