require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
  end
  
  describe "instance methods" do
    describe "#items_ready_to_ship" do
    it "returns items that are ready to ship" do
        merchant_1 = Merchant.create!(name: "Merchant 1")

        item_1 = Item.create!(name: "Item 1", description: "Item 1 description", unit_price: 1000, merchant_id: merchant_1.id)
        item_2 = Item.create!(name: "Item 2", description: "Item 2 description", unit_price: 2000, merchant_id: merchant_1.id)
        item_3 = Item.create!(name: "Item 3", description: "Item 3 description", unit_price: 3000, merchant_id: merchant_1.id)
        item_4 = Item.create!(name: "Item 4", description: "Item 4 description", unit_price: 4000, merchant_id: merchant_1.id)
        item_5 = Item.create!(name: "Item 5", description: "Item 5 description", unit_price: 5000, merchant_id: merchant_1.id)
        
        customer_1 = Customer.create!(first_name: "First Name 1", last_name: "Last Name 1")
        customer_2 = Customer.create!(first_name: "First Name 2", last_name: "Last Name 2")
        customer_3 = Customer.create!(first_name: "First Name 3", last_name: "Last Name 3")
        customer_4 = Customer.create!(first_name: "First Name 4", last_name: "Last Name 4")
        customer_5 = Customer.create!(first_name: "First Name 5", last_name: "Last Name 5")

        invoice_1 = Invoice.create!(customer_id: customer_1.id, merchant_id: merchant_1.id, status: 0)
        invoice_2 = Invoice.create!(customer_id: customer_2.id, merchant_id: merchant_1.id, status: 0)
        invoice_3 = Invoice.create!(customer_id: customer_3.id, merchant_id: merchant_1.id, status: 0)
        invoice_4 = Invoice.create!(customer_id: customer_4.id, merchant_id: merchant_1.id, status: 0)
        invoice_5 = Invoice.create!(customer_id: customer_5.id, merchant_id: merchant_1.id, status: 0)

        invoice_item_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, quantity: 1, unit_price: 1000, status: 0)
        invoice_item_2 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, quantity: 1, unit_price: 2000, status: 1)
        invoice_item_3 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, quantity: 1, unit_price: 3000, status: 2)
        invoice_item_4 = InvoiceItem.create!(item_id: item_4.id, invoice_id: invoice_4.id, quantity: 1, unit_price: 4000, status: 0)
        invoice_item_5 = InvoiceItem.create!(item_id: item_5.id, invoice_id: invoice_5.id, quantity: 1, unit_price: 5000, status: 0)

        transaction_1 = Transaction.create!(invoice_id: invoice_1.id, credit_card_number: 1234567890123456, result: 0)
        transaction_2 = Transaction.create!(invoice_id: invoice_2.id, credit_card_number: 1234567890123456, result: 0)
        transaction_3 = Transaction.create!(invoice_id: invoice_3.id, credit_card_number: 1234567890123456, result: 0)
        transaction_4 = Transaction.create!(invoice_id: invoice_4.id, credit_card_number: 1234567890123456, result: 0)
        transaction_5 = Transaction.create!(invoice_id: invoice_5.id, credit_card_number: 1234567890123456, result: 0)



      end
    end
    describe "#top_customers" do
      it "returns the top 5 customers with the most successful transactions for a specific merchant" do
      end
    end
    describe "#count_successful_transactions" do
      it "returns the count of successful transactions for a specific customer for the merchant" do
      end
    end
  end
end