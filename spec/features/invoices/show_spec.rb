require "rails_helper"

RSpec.describe "Merchant Invoice Show Page" do
  describe "as a Merchant" do
    scenario "I can see all that invoices information" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer)
      create(:invoice_item, invoice: invoice, item: item)

      visit merchant_invoice_path(merchant, invoice)

      expect(page).to have_content("Invoice #{invoice.id}")
      expect(page).to have_content("Status: #{invoice.status}")
      expect(page).to have_content("Created at: #{invoice.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Customer: #{customer.first_name} #{customer.last_name}")
    end
    scenario "I see all of my items information on the invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer)
      invoice_item = create(:invoice_item, invoice: invoice, item: item)

      visit merchant_invoice_path(merchant, invoice)

      expect(page).to have_content(item.name)
      expect(page).to have_content(invoice_item.quantity)
      expect(page).to have_content(invoice_item.unit_price/100.to_f)
      expect(page).to have_select('invoice_item_status', selected: invoice_item.status.titleize)
    end
    scenario "I see the total revenue that will be generated from all of my items on the invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer)
      invoice_item = create(:invoice_item, invoice: invoice, item: item, quantity: 2, unit_price: 1000)

      visit merchant_invoice_path(merchant, invoice)

      expect(page).to have_content("Total Possibe Revenue For Mechant")
      expect(page).to have_content("Total: $20.00")
    end
    scenario "I can update the status of an item on the invoice" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer)
      invoice_item = create(:invoice_item, invoice: invoice, item: item)

      visit merchant_invoice_path(merchant, invoice)
            

      expect(page).to have_content(invoice_item.item.name)
      select "Shipped", from: "invoice_item_status"
      click_button "Update Item Status"
      expect(invoice_item.reload.status).to eq("shipped")
    end
  end
end