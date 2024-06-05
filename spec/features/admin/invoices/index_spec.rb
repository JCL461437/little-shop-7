require "rails_helper"

RSpec.describe "Admin Invoices Index Page" do
    describe "as an Admin" do
        scenario "I see all of the invoices in the system, each invoice has an ID that is linked to its admin invoice show page" do
            customer = create(:customer)
            invoice1 = create(:invoice, customer: customer)
            invoice2 = create(:invoice, customer: customer)
            customer_2 = create(:customer)
            invoice3 = create(:invoice, customer: customer_2)


            visit admin_invoices_path

            within("#invoice_links") do
                expect(page).to have_link(invoice1.id)
                expect(page).to have_link(invoice2.id)
                expect(page).to have_link(invoice3.id)
            end
            click_link invoice1.id

            expect(current_path).to eq(admin_invoice_path(invoice1))
        end
    end
end