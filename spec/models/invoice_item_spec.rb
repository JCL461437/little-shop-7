require "rails_helper"

Rspec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to :invoice}
    it { should belong_to :item}
  end

  describe "validations" do
    it { should define_enum_for(:status).with_values([:pending, :packaged, :shipped]) }
  end
end
