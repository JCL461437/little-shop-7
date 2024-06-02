require "rails_helper"

RSpec.describe Item, type: :model do
  describe "relationships" do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items)}
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many(:customers).through(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "to_dollars method" do
    it "should convert an integer to a number that can represent dollars" do
      merchant = create(:merchant)
      item = merchant.items.create!(name: "Candle", description: "Pine Scented", unit_price: 1000)
      
      expect(item.unit_price).to eq(1000)
      
      price = item.to_dollars
      
      expect(price).to eq("$10.00")
    end
  end
end