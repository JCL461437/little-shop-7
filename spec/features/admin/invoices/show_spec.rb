require "rails_helper"

RSpec.describe "Admin Invoices Show Page" do
    describe "as an Admin" do
        scenario "I see the invoice's id, status, created_at date, customer first and last in the system" do
            customer = create(:customer)
            invoice = create(:invoice, customer: customer)

            visit admin_invoice_path(invoice)

            expect(page).to have_content("Invoice ID: #{invoice.id}")
            expect(page).to have_content("Status: #{invoice.status}")
            expect(page).to have_content("Invoice Date: #{invoice.created_at.strftime("%A, %B %d, %Y")}")
            expect(page).to have_content("Customer: #{customer.first_name} #{customer.last_name}")
        end
    end
end