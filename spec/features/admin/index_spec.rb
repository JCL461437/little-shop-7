require 'rails_helper'

RSpec.describe 'admin index' do
  include ApplicationHelper

  describe 'As an admin, when I visit the admin dashboard' do
    
    describe "header and links" do 
      it 'displays a header indicating that I am on the admin dashboard' do
        visit "/admin"

        expect(page).to have_content("Admin Dashboard")
      end

      it 'displays links to admin merchants and invoices indexes, and admin dash' do 
        visit "/admin"

        expect(page).to have_link("Merchants")
        expect(page).to have_link("Invoices")
        expect(page).to have_link("Dashboard")
      end
    end
    
    describe "top 5 customers section" do
      it "I see the names of the top 5 customers based on number of successful transactions along with that number" do
        customer_1 = Customer.create!(first_name: "A", last_name: "Man")
        customer_2 = Customer.create!(first_name: "B", last_name: "Man")
        customer_3 = Customer.create!(first_name: "C", last_name: "Man")
        customer_4 = Customer.create!(first_name: "D", last_name: "Man")
        customer_5 = Customer.create!(first_name: "E", last_name: "Man")
        customer_6 = Customer.create!(first_name: "Billy", last_name: "Bob")

        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
        invoice_4 = Invoice.create!(customer_id: customer_2.id, status: 1)
        invoice_5 = Invoice.create!(customer_id: customer_2.id, status: 1)
        invoice_6 = Invoice.create!(customer_id: customer_3.id, status: 2)
        invoice_7 = Invoice.create!(customer_id: customer_4.id, status: 1)
        invoice_8 = Invoice.create!(customer_id: customer_5.id, status: 1)
        invoice_9 = Invoice.create!(customer_id: customer_6.id, status: 1)

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, result: 0)
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, result: 0)
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, result: 0)
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, result: 0)
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, result: 0)
        transaction_6 = Transaction.create!(invoice_id: invoice_6.id, result: 0)
        transaction_7 = Transaction.create!(invoice_id: invoice_7.id, result: 0)
        transaction_8 = Transaction.create!(invoice_id: invoice_8.id, result: 0)
        transaction_9 = Transaction.create!(invoice_id: invoice_9.id, result: 1)

        visit "/admin"
        
        expect(Customer.count).to eq(6)
        expect(page).to have_content("Top Customers")
        expect("A Man").to appear_before("B Man")
        expect(page).to have_content("A Man - 3 purchases")
        expect(page).to have_content("B Man - 2 purchases")
        expect(page).to have_content("C Man - 1 purchases")
        expect(page).to have_content("D Man - 1 purchases")
        expect(page).to have_content("E Man - 1 purchases")
        expect(page).to_not have_content("Billy Bob")
      end
    end

    describe "incomplete invoices section" do
      it "shows section for Incomplete Invoices" do 
        visit "/admin"
        # save_and_open_page
        expect(page).to have_content("Incomplete Invoices")
      end

      it "shows list of the ids of all invoices that have items that have not yet been shipped" do
        # setup: 2 invoices w items not shipped, 1 invoice with shipped item (invoice_items.status) 
        # enum "shipped" = 2
        customer_1 = Customer.create!
        merchant_1 = Merchant.create!
        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0, created_at: "Saturday, June 1, 2024")
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 0)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
        item_1 = Item.create!(merchant_id: merchant_1.id)
        item_2 = Item.create!(merchant_id: merchant_1.id)
        item_3 = Item.create!(merchant_id: merchant_1.id)
        ii_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)
        ii_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
        ii_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 2)
        #need to add more ii's because could have multiple items(and ii's) on one invoice
        #need to add orderly assertion, and more invoices to prove it, and change created_at dates to verify
        visit "/admin"
        # save_and_open_page
        binding.pry
        expect(page).to have_content("Invoice ##{invoice_1.id} - #{formatted_date(invoice_1.created_at)}")
        expect(page).to have_content("Invoice ##{invoice_2.id} - #{formatted_date(invoice_2.created_at)}")
        expect("#{invoice_1.id}").to appear_before("#{invoice_2.id}")
        expect(page).to_not have_content(invoice_3.id)
      end

      #update model test for class method

      xit "and each invoice id links to that invoice's admin show page" do
        visit "/admin"
      end

    end
  end
end