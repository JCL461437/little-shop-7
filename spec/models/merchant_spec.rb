require "rails_helper"

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it { should have_many :items }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
  end
  
  describe "instance methods" do
      let(:merchant) { create(:merchant) }
      let(:customer) { create(:customer) }

      describe "#items_ready_to_ship" do
        it "returns items that are ready to ship from oldest to newest" do
          # item_1 = create(:item, merchant: merchant)
          # item_2 = create(:item, merchant: merchant)
          # item_3 = create(:item, merchant: merchant)

          # invoice = create(:invoice, customer: customer, items: [item_1, item_2, item_3])

          # invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice, status: 2)
          # invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice, status: 2)
          # invoice_item_3 = create(:invoice_item, item: item_3, invoice: invoice, status: 0)

          # transaction = create(:transaction, invoice: invoice, result: 0)
          item_1 = create(:item, merchant: merchant)
          item_2 = create(:item, merchant: merchant)
          item_3 = create(:item, merchant: merchant)

          invoice_1 = create(:invoice, customer: customer, created_at: 2.days.ago)
          invoice_2 = create(:invoice, customer: customer, created_at: 1.day.ago)

          create(:invoice_item, item: item_1, invoice: invoice_1, status: 2)
          create(:invoice_item, item: item_2, invoice: invoice_2, status: 2)
          create(:invoice_item, item: item_3, invoice: invoice_1, status: 0)

          create(:transaction, invoice: invoice_1, result: 0)
          create(:transaction, invoice: invoice_2, result: 0)

          expect(merchant.items_ready_to_ship).to eq([item_2, item_1])
        end
      end
      describe "#top_customers" do
        it "returns the top 5 customers with the most successful transactions for a specific merchant" do
          customer_1 = create(:customer)
          customer_2 = create(:customer)
          customer_3 = create(:customer)
          customer_4 = create(:customer)
          customer_5 = create(:customer)
          customer_6 = create(:customer)
          
          item_1 = create(:item, merchant: merchant)

          invoice_1 = create(:invoice, customer: customer_1, items: [item_1])
          invoice_2 = create(:invoice, customer: customer_2, items: [item_1])
          invoice_3 = create(:invoice, customer: customer_3, items: [item_1])
          invoice_4 = create(:invoice, customer: customer_4, items: [item_1])
          invoice_5 = create(:invoice, customer: customer_5, items: [item_1])
          invoice_6 = create(:invoice, customer: customer_6, items: [item_1])
          invoice_7 = create(:invoice, customer: customer_1, items: [item_1])
          invoice_8 = create(:invoice, customer: customer_1, items: [item_1])
          invoice_9 = create(:invoice, customer: customer_2, items: [item_1])

          create(:transaction, invoice: invoice_1, result: 0)
          create(:transaction, invoice: invoice_2, result: 0)
          create(:transaction, invoice: invoice_3, result: 0)
          create(:transaction, invoice: invoice_4, result: 0)
          create(:transaction, invoice: invoice_5, result: 0)
          create(:transaction, invoice: invoice_6, result: 1)
          create(:transaction, invoice: invoice_7, result: 1)
          create(:transaction, invoice: invoice_8, result: 1)
          create(:transaction, invoice: invoice_9, result: 1)

          

          expect(merchant.top_customers).to eq([customer_1, customer_2, customer_3, customer_4, customer_5])
        end
      end
      describe "#count_successful_transactions" do
        it "returns the count of successful transactions for a specific customer for the merchant" do
          customer_1 = create(:customer)
          customer_2 = create(:customer)
          customer_3 = create(:customer)
          customer_4 = create(:customer)
          customer_5 = create(:customer)
          customer_6 = create(:customer)
          
          item_1 = create(:item, merchant: merchant)

          invoice_1 = create(:invoice, customer: customer_1, items: [item_1])
          invoice_2 = create(:invoice, customer: customer_2, items: [item_1])
          invoice_3 = create(:invoice, customer: customer_3, items: [item_1])
          invoice_4 = create(:invoice, customer: customer_4, items: [item_1])
          invoice_5 = create(:invoice, customer: customer_5, items: [item_1])
          invoice_6 = create(:invoice, customer: customer_6, items: [item_1])
          invoice_7 = create(:invoice, customer: customer_1, items: [item_1])
          invoice_8 = create(:invoice, customer: customer_1, items: [item_1])
          invoice_9 = create(:invoice, customer: customer_2, items: [item_1])

          create(:transaction, invoice: invoice_1, result: 0)
          create(:transaction, invoice: invoice_2, result: 0)
          create(:transaction, invoice: invoice_3, result: 0)
          create(:transaction, invoice: invoice_4, result: 0)
          create(:transaction, invoice: invoice_5, result: 0)
          create(:transaction, invoice: invoice_6, result: 1)
          create(:transaction, invoice: invoice_7, result: 0)
          create(:transaction, invoice: invoice_8, result: 1)
          create(:transaction, invoice: invoice_9, result: 1)

          expect(merchant.count_successful_transactions(customer_1)).to eq(2)
          expect(merchant.count_successful_transactions(customer_2)).to eq(1)
          expect(merchant.count_successful_transactions(customer_6)).to eq(0)
        end
      end
  end
end