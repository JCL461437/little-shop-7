class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices
  
  def items_ready_to_ship
    items.joins(:invoice_items)
          .where('invoice_items.status = ?', 2)
          .distinct
  end

  def top_customers
    customers.joins(:transactions)
            .where('transactions.result = ?', 0)
            .group('customers.id')
            .order('count(transactions.id) desc')
            .limit(5)
  end
end