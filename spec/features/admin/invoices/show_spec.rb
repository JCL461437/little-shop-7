require "rails_helper"

RSpec.describe "Admin Invoices Show Page" do
    describe "as an Admin" do
        scenario "I see the invoice's id, status, created_at date, customer first and last in the system" do
            customer = create(:customer)
            invoice = create(:invoice, customer: customer)

            visit admin_invoice_path(invoice)

            within("#invoice_info") do
                expect(page).to have_content("Invoice ID: #{invoice.id}")
                expect(page).to have_select('invoice_status', selected: invoice.status.titleize)
                expect(page).to have_content("Invoice Date: #{invoice.created_at.strftime("%A, %B %d, %Y")}")
                expect(page).to have_content("Customer: #{customer.first_name} #{customer.last_name}")
            end
        end
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
        scenario "I see the total revenue that will be generated from this invoice" do
            customer = create(:customer)
            invoice = create(:invoice, customer: customer)
            item_1 = create(:item, unit_price: 10000)
            item_2 = create(:item, unit_price: 2000)
            create(:invoice_item, invoice: invoice, item: item_1, quantity: 2, unit_price: 10000)
            create(:invoice_item, invoice: invoice, item: item_2, quantity: 5, unit_price: 2000)

            visit admin_invoice_path(invoice)

            within("#invoice_total_revenue") do
                expect(page).to have_content("Total Revenue: $300.00")
            end
        end
        scenario "I see the invoice status is a select field and I can update the status" do
            customer = create(:customer)
            invoice = create(:invoice, customer: customer)

            visit admin_invoice_path(invoice)

            within("#invoice_info") do
                expect(page).to have_select("invoice_status", selected: invoice.status.titleize)
                select "Completed", from: "invoice_status"
                click_button "Update Invoice Status"
            end

            expect(current_path).to eq(admin_invoice_path(invoice))
            expect(page).to have_select('invoice_status', selected: 'Completed')
            expect(invoice.reload.status).to eq("completed")
        end
    end
end