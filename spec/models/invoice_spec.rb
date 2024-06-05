require "rails_helper"

RSpec.describe Invoice, type: :model do
	describe "relationships" do
			it { should belong_to :customer }
			it { should have_many :invoice_items }
			it { should have_many :transactions }
			it { should have_many(:items).through(:invoice_items) }
			it { should have_many(:merchants).through(:items) }
	end
	
	describe "validations" do
			it { should define_enum_for(:status).with_values([:"in progress", :completed, :cancelled]) }
	end

	describe "class methods" do
		context "#incomplete_invoices" do
			it "should return all invoices with unshipped items from oldest to newest" do
				customer_1 = Customer.create!
        merchant_1 = Merchant.create!(name: "Joeman")
        invoice_1 = Invoice.create!(customer_id: customer_1.id, status: 0, created_at: "Saturday, June 1, 2024")
        invoice_2 = Invoice.create!(customer_id: customer_1.id, status: 0)
        invoice_3 = Invoice.create!(customer_id: customer_1.id, status: 1)
        item_1 = Item.create!(merchant_id: merchant_1.id)
        item_2 = Item.create!(merchant_id: merchant_1.id)
        item_3 = Item.create!(merchant_id: merchant_1.id)
        ii_1 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)
        ii_2 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_1.id, status: 0)
        ii_3 = InvoiceItem.create!(item_id: item_1.id, invoice_id: invoice_2.id, status: 0)
        ii_4 = InvoiceItem.create!(item_id: item_2.id, invoice_id: invoice_2.id, status: 1)
        ii_5 = InvoiceItem.create!(item_id: item_3.id, invoice_id: invoice_3.id, status: 2)

				incomplete_invoices = Invoice.incomplete_invoices

				expect(incomplete_invoices.length).to eq(2)
			end
		end
	end
	describe "instance methods" do
		context "#merchant_total_revenue" do
			it "should return the total revenue for a merchant's items on an invoice" do
				merchant = create(:merchant)
				customer = create(:customer)
				item = create(:item, merchant: merchant)
				invoice = create(:invoice, customer: customer)
				invoice_item = create(:invoice_item, invoice: invoice, item: item)

				expect(invoice.merchant_total_revenue(merchant)).to eq(invoice_item.quantity * invoice_item.unit_price)
			end
		end
	end
end