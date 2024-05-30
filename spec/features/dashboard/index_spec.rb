require "rails_helper"

RSpec.describe "Merchant Dashboard Show Page" do
    before(:each) do
        @merchant = create(:merchant)
    end

    describe "as a Merchant" do
        scenario "I see the name of my Merchant" do
            visit merchant_dashboard_index_path(@merchant)
            within("#page_info") do
                expect(page).to have_content(@merchant.name)
            end
        end
        scenario "I see a link to my items index and invoices" do
            visit merchant_dashboard_index_path(@merchant)

            within("#page_info") do
                expect(page).to have_link("My Items")
                expect(page).to have_link("My Invoices")
            end
        end
        scenario "I see a div for top customers and shows the top 5 customers" do
            visit merchant_dashboard_index_path(@merchant)

            within("#top_customers") do
                expect(page).to have_content("Top Customers")
                expect(page).to have_content("Customer Name")
                expect(page).to have_content("Number of Successful Transactions")
                # add expects to check for top 5 customers
            end
        end
    end
end