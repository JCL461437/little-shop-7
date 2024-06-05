require 'rails_helper'

RSpec.describe "admin merchants index" do

  describe "As an admin when I visit the admin merchants index (/admin/merchants)" do
    describe "display" do
      it "I see the name of each merchant in the system" do
        merchants = FactoryBot.create_list(:merchant, 10)

        visit admin_merchants_path
        
        merchants.each do |merchant|
          expect(page).to have_content(merchant.name)
        end
      end
    end

    describe "When I click on the name of a merchant" do
      it "I am taken to (/admin/merchants/:merchant_id) and see merchant's name" do
        merchant_1 = Merchant.create!(name: "Acme")
        merchant_2 = Merchant.create!(name: "BigBox")
        
        visit admin_merchants_path

        click_link(merchant_1.name)

        expect(current_path).to eq(admin_merchant_path(merchant_1))
        expect(page).to have_content("Acme")
        expect(page).to_not have_content("BigBox")
      end
    end

    describe "I see a button to disable or enable that merchant" do
      it "Displays a button that can change a merchant's status" do
        merchant_1 = Merchant.create!(name: "Mans Machines", status: 1, id: 500)
        merchant_2 = Merchant.create!(name: "Guys Gizzmos", status: 1, id: 501)
        merchant_3 = Merchant.create!(name: "Weasels Wallets", status: 0, id: 502)

        visit admin_merchants_path

        within ('#enabled_merchants') do
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content(merchant_2.name)
          expect(page).to_not have_content(merchant_3.name)
        end
      
        within ('#disabled_merchants') do
          expect(page).to have_content(merchant_3.name)
          expect(page).to_not have_content(merchant_2.name)
          expect(page).to_not have_content(merchant_1.name)
        end

        within ('#disabled_merchant_502') do
          click_button 'Enable'
        end
        
        expect(current_path).to eq(admin_merchants_path)

        within ('#enabled_merchants') do
          expect(page).to have_content(merchant_1.name)
          expect(page).to have_content(merchant_2.name)
          expect(page).to have_content(merchant_3.name)
        end

        within ('#enabled_merchant_502') do
          click_button 'Disable'
        end

        expect(current_path).to eq(admin_merchants_path)

        within ('#disabled_merchants') do
          expect(page).to have_content(merchant_3.name)
        end

        within ('#enabled_merchants') do
          expect(page).to_not have_content(merchant_3.name)
        end
      end
    end

    describe "I see a link to create a new merchant" do
      it "will take me to a new form that allows me to add merchant information, and when I click submit, I see a new merchant with the information I filled in on the page with a default status of disabled" do
        visit admin_merchants_path

        expect(page).to have_link("New Merchant")
        click_link "New Merchant"
        
        expect(current_path).to eq(new_admin_merchant_path)
        
        fill_in "Name", with: "Craig Jones"
        click_button "Submit"

        new_merchant_id = Merchant.last.id
        
        expect(current_path).to eq(admin_merchants_path)
        
        within ("#disabled_merchants") do
          expect(page).to have_content("Craig Jones")
        end

      end
    end

    describe "top 5 merchants section" do
      # Invoice_items status: pending (0), packaged (1), shipped (2)
      # Invoices status: in progress (0), completed (1), cancelled (2)
      # Transactions results: success (0), failed (1)

      # Only invoices with at least one successful transaction should count towards revenue
      # Revenue for an invoice should be calculated as the sum of the revenue of all invoice items
      # Revenue for an invoice item should be calculated as the invoice item unit price multiplied by the quantity (do not use the item unit price)

      it "I see the names of the top 5 merchants by total revenue generated, shown next to each name" do 
        merchant_1 = Merchant.create!(name: "A")
        merchant_2 = Merchant.create!(name: "B")
        merchant_3 = Merchant.create!(name: "C")
        merchant_4 = Merchant.create!(name: "D")
        merchant_5 = Merchant.create!(name: "E")
        merchant_6 = Merchant.create!(name: "F")

        customer_1 = Customer.create!(first_name: "Jan", last_name: "Monkey")

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 0)

        item_1 = Item.create!(merchant_id: merchant_1.id)
        item_2 = Item.create!(merchant_id: merchant_1.id)
        item_3 = Item.create!(merchant_id: merchant_2.id)
        item_4 = Item.create!(merchant_id: merchant_3.id)
        item_5 = Item.create!(merchant_id: merchant_4.id)
        item_6 = Item.create!(merchant_id: merchant_5.id)
        item_7 = Item.create!(merchant_id: merchant_6.id)

        InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 1, unit_price: 10, quantity: 2)
        InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_7.id, status: 1, unit_price: 10, quantity: 1)

        invoice_1.transactions.create!(result: 0) 
        invoice_2.transactions.create!(result: 0) 
        invoice_3.transactions.create!(result: 0) 
        invoice_4.transactions.create!(result: 0) 
        invoice_5.transactions.create!(result: 0) 
        invoice_6.transactions.create!(result: 0) 
        invoice_7.transactions.create!(result: 1) 

        visit admin_merchants_path
        
        within ("#top_merchants") do
          expect(page).to have_content("Top Merchants")
          expect(page).to have_content("A - $30 in sales")
          expect(page).to have_content("B - $10 in sales")
          expect(page).to have_content("C - $10 in sales")
          expect(page).to have_content("D - $10 in sales")
          expect(page).to have_content("E - $10 in sales")
          expect(page).to_not have_content("F - $0 in sales")
        end
      end

      it "the top 5 merchants have the best day for revenue, shown below to each of their names." do 
        merchant_1 = Merchant.create!(name: "A")
        merchant_2 = Merchant.create!(name: "B")
        merchant_3 = Merchant.create!(name: "C")
        merchant_4 = Merchant.create!(name: "D")
        merchant_5 = Merchant.create!(name: "E")
        merchant_6 = Merchant.create!(name: "F")

        customer_1 = Customer.create!(first_name: "Jan", last_name: "Monkey")

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_6 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_7 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_8 = Invoice.create!(customer_id: customer_1.id, status: 0)

        item_1 = Item.create!(merchant_id: merchant_1.id)
        item_2 = Item.create!(merchant_id: merchant_1.id)
        item_3 = Item.create!(merchant_id: merchant_2.id)
        item_4 = Item.create!(merchant_id: merchant_3.id)
        item_5 = Item.create!(merchant_id: merchant_4.id)
        item_6 = Item.create!(merchant_id: merchant_5.id)
        item_7 = Item.create!(merchant_id: merchant_6.id)

        InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 1, unit_price: 10, quantity: 2, created_at: 2024-06-05)
        InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1, unit_price: 10, quantity: 1, created_at: 2024-06-05)
        InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 1, unit_price: 10, quantity: 1, created_at: 2024-06-05)
        InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1, unit_price: 10, quantity: 1, created_at: 2024-06-05)
        InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: 1, unit_price: 10, quantity: 1, created_at: 2024-06-05)
        InvoiceItem.create!(item_id: item_6.id, invoice_id: invoice_6.id, status: 1, unit_price: 10, quantity: 1, created_at: 2024-06-05)
        InvoiceItem.create!(item_id: item_7.id, invoice_id: invoice_7.id, status: 1, unit_price: 10, quantity: 1, created_at: 2024-06-05)

        invoice_1.transactions.create!(result: 0, created_at: 2024-06-05)
        invoice_2.transactions.create!(result: 0, created_at: 2024-06-05) 
        invoice_3.transactions.create!(result: 0, created_at: 2024-06-05) 
        invoice_4.transactions.create!(result: 0, created_at: 2024-06-05) 
        invoice_5.transactions.create!(result: 0, created_at: 2024-06-05) 
        invoice_6.transactions.create!(result: 0, created_at: 2024-06-05) 
        invoice_7.transactions.create!(result: 1, created_at: 2024-06-05) 

        visit admin_merchants_path
        
        save_and_open_page

        within ("#top_merchants") do
          expect(page).to have_content("Top day for A was 2024-06-05")
          expect(page).to have_content("Top day for B was 2024-06-05")
          expect(page).to have_content("Top day for C was 2024-06-05")
          expect(page).to have_content("Top day for D was 2024-06-05")
          expect(page).to have_content("Top day for E was 2024-06-05")
          expect(page).to_not have_content("Top day for F was 2024-06-05")
        end
      end

      it "each merchants name links to the admin merchant show page for that merchant" do 
        merchant_1 = Merchant.create!(name: "A")
        merchant_2 = Merchant.create!(name: "B")
        merchant_3 = Merchant.create!(name: "C")
        merchant_4 = Merchant.create!(name: "D")
        merchant_5 = Merchant.create!(name: "E")

        customer_1 = Customer.create!(first_name: "Jan", last_name: "Monkey")

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_4 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_5 = Invoice.create!(customer_id: customer_1.id, status: 1)

        item_1 = Item.create!(merchant_id: merchant_1.id)
        item_2 = Item.create!(merchant_id: merchant_1.id)
        item_3 = Item.create!(merchant_id: merchant_2.id)
        item_4 = Item.create!(merchant_id: merchant_3.id)
        item_5 = Item.create!(merchant_id: merchant_4.id)
        item_6 = Item.create!(merchant_id: merchant_5.id)

        InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 1, unit_price: 10, quantity: 2)
        InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, status: 1, unit_price: 10, quantity: 1)
        InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, status: 1, unit_price: 10, quantity: 1)

        invoice_1.transactions.create!(result: 0) 
        invoice_2.transactions.create!(result: 0) 
        invoice_3.transactions.create!(result: 0) 
        invoice_4.transactions.create!(result: 0) 
        invoice_5.transactions.create!(result: 0) 

        visit admin_merchants_path

        click_link("A")

        expect(current_path).to eq(admin_merchant_path(merchant_1))
      end

    end
  end
end
