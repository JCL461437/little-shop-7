require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_many :invoices}
    it { should have_many(:transactions).through(:invoices)}
    it { should have_many(:merchants).through(:invoices)}
  end

  describe "class methods" do 
    it "should return the customers with the most purchases in order" do
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
      
      top_customers = Customer.top_five_customers

      expect(top_customers.length).to eq(5)
      expect(top_customers[0].full_name).to eq("A Man")
      expect(top_customers[0].count_of_purchases).to eq(3)
      expect(top_customers[1].full_name).to eq("B Man")
      expect(top_customers[1].count_of_purchases).to eq(2)
      expect(top_customers[2].full_name).to eq("C Man")
      expect(top_customers[2].count_of_purchases).to eq(1)
      expect(top_customers[3].full_name).to eq("D Man")
      expect(top_customers[3].count_of_purchases).to eq(1)
      expect(top_customers[4].full_name).to eq("E Man")
      expect(top_customers[4].count_of_purchases).to eq(1)
    end
  end
end