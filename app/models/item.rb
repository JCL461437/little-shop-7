class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.top_five_items
    joins(invoices: :transactions)
    .where(transactions: {result: 'success'})
    .select('items.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .group(:id)
    .order('revenue DESC')
    .limit(5)
  end
# Top 5 items by revenue
# call @merchant.items.top_five_items.each do |item|
# item.name
# item.revenue

end