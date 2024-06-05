class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  enum status: {disabled: 0, enabled: 1}

  validates :name, presence: true 
  
  def items_ready_to_ship
    items.joins(invoice_items: :invoice)
          .where('invoice_items.status = ?', 2)
          .select('items.*, invoices.created_at, invoices.id as invoice_id')
          .order('invoices.created_at asc')
          .distinct
  end

  def top_customers
    customers.joins(invoices: :transactions)
            .where(transactions: { result: 0 })
            .group('customers.id')
            .order('COUNT(transactions.id) DESC')
            .select('customers.*, COUNT(transactions.id) AS transactions_count')
            .limit(5)
  end

  def self.enabled_merchants
    Merchant.where(status: [:enabled])
  end

  def self.disabled_merchants
    Merchant.where(status: [:disabled])
  end

  def self.top_five_merchants
             joins(invoices: :transactions)
            .where(transactions: { result: 0})
            .select("merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) as revenue")
            .group(:id)
            .order("revenue desc")
            .limit(5)
  end
end