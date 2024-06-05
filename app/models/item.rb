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

  def best_day
    invoices.joins(:transactions)
            .where(transactions: {result: 'success'})
            .select('invoices.created_at, SUM(invoice_items.quantity)')
            .group('invoices.id, invoices.created_at')
            .order('SUM(invoice_items.quantity) DESC, invoices.created_at DESC')
            .first
            .created_at
  end
  # call @merchant.items.top_five_items.each do |item|
  # item.best_day



  enum status: {disabled: 0, enabled: 1}

  def self.enabled_items
    Item.where(status: [:enabled])
  end

  def self.disabled_items
    Item.where(status: [:disabled])
  end
end