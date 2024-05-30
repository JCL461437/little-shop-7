class Merchant < ApplicationRecord
  has_many :items
  
  def items_ready_to_ship
    items.joins(:invoice_items)
          .where('invoice_items.status = ?', 2)
          .distinct
  end

  def top_customers
    Customer.joins(invoices: :transactions)
            .where('transactions.results = ?', 0)
            .group('customers.id')
            .order('count(transactions.id) desc')
            .limit(5)
  end
end