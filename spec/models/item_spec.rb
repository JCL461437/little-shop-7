require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "class methods" do
    describe "#top_five_items" do
      it "returns the top 5 items by revenue" do
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

        expect(merchant.items.top_five_items).to eq([item_6, item_5, item_4, item_3, item_2])
      end
    end
  end
  describe "instance methods" do
    describe "#best_day" do
      it "returns the date with the most sales for the item" do
        merchant = create(:merchant)
        item = create(:item, merchant: merchant)

        customer = create(:customer)
        invoice_1 = create(:invoice, customer: customer, created_at: "2020-01-01")
        invoice_5 = create(:invoice, customer: customer, created_at: "2020-01-05")
        invoice_6 = create(:invoice, customer: customer, created_at: "2020-01-06")

        create(:invoice_item, item: item, invoice: invoice_1, quantity: 1, unit_price: 1000)
        create(:invoice_item, item: item, invoice: invoice_5, quantity: 5, unit_price: 5000)
        create(:invoice_item, item: item, invoice: invoice_6, quantity: 6, unit_price: 6000)

        create(:transaction, invoice: invoice_1, result: 0)
        create(:transaction, invoice: invoice_5, result: 0)
        create(:transaction, invoice: invoice_6, result: 0)

        expect(item.best_day).to eq(invoice_6.created_at)
      end
    end
  end
end