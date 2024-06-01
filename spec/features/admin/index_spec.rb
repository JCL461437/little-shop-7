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
 
    it "I see the names of the top 5 customers based on number of successful transactions along with their number" do
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
end