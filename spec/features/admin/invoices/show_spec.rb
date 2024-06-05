require "rails_helper"

RSpec.describe "Admin Invoices Show Page" do
    describe "as an Admin" do
        scenario "I see the invoice's id, status, created_at date, customer first and last in the system" do
            customer = create(:customer)
            invoice = create(:invoice, customer: customer)

            visit admin_invoice_path(invoice)

            within("#invoice_info") do
                expect(page).to have_content("Invoice ID: #{invoice.id}")
                expect(page).to have_content("Status: #{invoice.status}")
                expect(page).to have_content("Invoice Date: #{invoice.created_at.strftime("%A, %B %d, %Y")}")
                expect(page).to have_content("Customer: #{customer.first_name} #{customer.last_name}")
            end
        end
        # 34. Admin Invoice Show Page: Invoice Item Information

        # As an admin
        # When I visit an admin invoice show page (/admin/invoices/:invoice_id)
        # Then I see all of the items on the invoice including:
        # - Item name
        # - The quantity of the item ordered
        # - The price the Item sold for
        # - The Invoice Item status
        scenario "I see all of the items on the invoice including: Item name, quantity, price, and status" do
            customer = create(:customer)
            invoice = create(:invoice, customer: customer)
            item_1 = create(:item, unit_price: 10000)
            item_2 = create(:item, unit_price: 2000)
            invoice_item_1 = create(:invoice_item, invoice: invoice, item: item_1)
            invoice_item_2 = create(:invoice_item, invoice: invoice, item: item_2)

            visit admin_invoice_path(invoice)

            within("#invoice_items") do
                expect(page).to have_content(item_1.name)
                expect(page).to have_content(invoice_item_1.quantity)
                expect(page).to have_content("$100.00")
                expect(page).to have_content(invoice_item_1.status)
                expect(page).to have_content(item_2.name)
                expect(page).to have_content(invoice_item_2.quantity)
                expect(page).to have_content("$20.00")
                expect(page).to have_content(invoice_item_2.status)
            end
        end
    end
end