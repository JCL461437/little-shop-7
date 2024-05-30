require 'rails_helper'

RSpec.describe 'admin index' do

  describe 'As an admin, when I visit the admin dashboard' do
    it 'displays a header indicating that I am on the admin dashboard' do
      visit "/admin"

      expect(page).to have_content("Admin Dashboard")
      expect(page).to have_link("Dashboard")
    end

    it 'displays a link to the admin merchants and invoices indicies' do 
      visit "/admin"
      
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Invoices")
    end

    it 'displays a link to the admin merchants and invoices indicies' do
      visit "/admin"
     
      expect(page).to have_link("Merchants")
      expect(page).to have_link("Invoices")
    end
 
    it "I see the names of the top 5 customers based on number of successful transactions along with their number" do
      # top5customers = create_list(:customer, 5) - I'd love to incorporate factorybot but not sure here.
      customer_1 = Customer.create!(first_name: "A", last_name: "Man")
      customer_2 = Customer.create!(first_name: "B", last_name: "Man")
      customer_3 = Customer.create!(first_name: "C", last_name: "Man")
      customer_4 = Customer.create!(first_name: "D", last_name: "Man")
      customer_5 = Customer.create!(first_name: "E", last_name: "Man")
      customer_6 = Customer.create!(first_name: "Billy", last_name: "Bob")
      #create! 1 successful transaction for 5 different invoices and 5 different customers. Customer 6 has none.
      #the transaction.invoice_id has to match the invoice_id
      invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 1)
      invoice_2 = Invoice.create!(customer_id: customer_2.id, status: 1)
      invoice_3 = Invoice.create!(customer_id: customer_3.id, status: 1)
      invoice_4 = Invoice.create!(customer_id: customer_4.id, status: 1)
      invoice_5 = Invoice.create!(customer_id: customer_5.id, status: 1)
      invoice_6 = Invoice.create!(customer_id: customer_6.id, status: 2)
      transaction_1 = Transaction.create!(invoice_id: 1, result: 0)
      transaction_2 = Transaction.create!(invoice_id: 2, result: 0)
      transaction_3 = Transaction.create!(invoice_id: 3, result: 0)
      transaction_4 = Transaction.create!(invoice_id: 4, result: 0)
      transaction_5 = Transaction.create!(invoice_id: 5, result: 0)
      transaction_6 = Transaction.create!(invoice_id: 6, result: 1)
      binding.pry
      visit "/admin"
 
      expect(Customer.count).to eq(6)
      expect(page).to have_content("Top Customers")
      expect(page).to have_content("A Man - 1 purchases")
      expect(page).to have_content("B Man - 1 purchases")
      expect(page).to have_content("C Man - 1 purchases")
      expect(page).to have_content("D Man - 1 purchases")
      expect(page).to have_content("E Man - 1 purchases")
      expect(page).to_not have_content("Billy Bob")
    end
  end
end