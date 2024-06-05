require "rails_helper"

RSpec.describe "Merchant Index Page" do
  before(:each) do
    @merchant = create(:merchant)
    @merchant2 = create(:merchant)
    @item = @merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
    @item2 = @merchant.items.create!(name: "Soap", description: "Fresh Spring", unit_price: 1500)
    @item3 = @merchant2.items.create!(name: "Coaster", description: "Mahogany", unit_price: 500)
  end

  describe "As a Merchant" do
    describe "When I visit the merchant items index" do
      it "I see a list of only my items names" do
        visit "/merchants/#{@merchant.id}/items"

        expect(page).to have_content("My Items")
        expect(page).to have_content(@item.name)
        expect(page).to have_content(@item2.name)
        expect(page).to_not have_content(@item3.name)
      end
    end
  end

  describe "As a Merchant" do
    it "There is a button to disable/enable the item" do
      visit "/merchants/#{@merchant.id}/items"
    
      within "#disabled_item_#{@item.id}" do
        click_on("Enable")
      end

      expect(current_path).to eq "/merchants/#{@merchant.id}/items"
      expect(page).to have_content("Disable")
    end
    it "I see the names of the top 5 most popular items ranked by total revenue generated" do
        merchant = create(:merchant)
        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)
        item_4 = create(:item, merchant: merchant)
        item_5 = create(:item, merchant: merchant)
        item_6 = create(:item, merchant: merchant)

        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer)
        invoice_2 = create(:invoice, customer: customer)
        invoice_3 = create(:invoice, customer: customer)
        invoice_4 = create(:invoice, customer: customer)
        invoice_5 = create(:invoice, customer: customer)
        invoice_6 = create(:invoice, customer: customer)

        create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1000)
        create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 1, unit_price: 2000)
        create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 1, unit_price: 3000)
        create(:invoice_item, item: item_4, invoice: invoice_4, quantity: 1, unit_price: 4000)
        create(:invoice_item, item: item_5, invoice: invoice_5, quantity: 1, unit_price: 5000)
        create(:invoice_item, item: item_6, invoice: invoice_6, quantity: 1, unit_price: 6000)

        create(:transaction, invoice: invoice_1, result: 0)
        create(:transaction, invoice: invoice_2, result: 0)
        create(:transaction, invoice: invoice_3, result: 0)
        create(:transaction, invoice: invoice_4, result: 0)
        create(:transaction, invoice: invoice_5, result: 0)
        create(:transaction, invoice: invoice_6, result: 0)

      visit merchant_items_path(merchant)

      within "#top_5_items" do
        expect(page).to have_content("Top 5 Items")
        expect(page).to have_link(item_6.name)
        expect(page).to have_content("Revenue: $60.00")
        expect(page).to have_link(item_5.name)
        expect(page).to have_content("Revenue: $50.00")
        expect(page).to have_link(item_4.name)
        expect(page).to have_content("Revenue: $40.00")
        expect(page).to have_link(item_3.name)
        expect(page).to have_content("Revenue: $30.00")
        expect(page).to have_link(item_2.name)
        expect(page).to have_content("Revenue: $20.00")
      end
    end
      it "I see the date with the most sales for each item" do
        merchant = create(:merchant)
        item_1 = create(:item, merchant: merchant)
        item_2 = create(:item, merchant: merchant)
        item_3 = create(:item, merchant: merchant)
        item_4 = create(:item, merchant: merchant)
        item_5 = create(:item, merchant: merchant)
        item_6 = create(:item, merchant: merchant)

        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer)
        invoice_2 = create(:invoice, customer: customer)
        invoice_3 = create(:invoice, customer: customer)
        invoice_4 = create(:invoice, customer: customer)
        invoice_5 = create(:invoice, customer: customer)
        invoice_6 = create(:invoice, customer: customer)

        create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 1, unit_price: 1000)
        create(:invoice_item, item: item_2, invoice: invoice_2, quantity: 1, unit_price: 2000)
        create(:invoice_item, item: item_3, invoice: invoice_3, quantity: 1, unit_price: 3000)
        create(:invoice_item, item: item_4, invoice: invoice_4, quantity: 1, unit_price: 4000)
        create(:invoice_item, item: item_5, invoice: invoice_5, quantity: 1, unit_price: 5000)
        create(:invoice_item, item: item_6, invoice: invoice_6, quantity: 1, unit_price: 6000)

        create(:transaction, invoice: invoice_1, result: 0)
        create(:transaction, invoice: invoice_2, result: 0)
        create(:transaction, invoice: invoice_3, result: 0)
        create(:transaction, invoice: invoice_4, result: 0)
        create(:transaction, invoice: invoice_5, result: 0)
        create(:transaction, invoice: invoice_6, result: 0)

      visit merchant_items_path(merchant)

      within "#top_5_items" do
        expect(page).to have_content("Top 5 Items")
        expect(page).to have_link(item_6.name)
        expect(page).to have_content("Revenue: $60.00")
        expect(page).to have_content("Best Day: #{invoice_6.created_at.strftime('%A, %B %d, %Y')}")
      end
    end
  end
end