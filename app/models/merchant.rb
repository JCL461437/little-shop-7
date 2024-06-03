class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices, through: :items
  has_many :customers, through: :invoices

  enum status: {disabled: 0, enabled: 1}
  
  def items_ready_to_ship
    items.joins(invoice_items: :invoice)
          .where('invoice_items.status = ?', 2)
          .select('items.*, invoices.created_at, invoices.id as invoice_id')
          .order('invoices.created_at asc')
          .distinct
  end

  # def top_customers
  #   customers.joins(:transactions)
  #           .where('transactions.result = ?', 0)
  #           .group('customers.id')
  #           .order('count(transactions.id) desc')
  #           .limit(5)
  # end

  # def count_successful_transactions(customer)
  #   invoices.joins(:transactions)
  #           .where(customer_id: customer.id, transactions: { result: 0 })
  #           .count('transactions.id')
  # end

  def top_customers
    customers.joins(invoices: :transactions)
            .where(transactions: { result: 0 })
            .group('customers.id')
            .order('COUNT(transactions.id) DESC')
            .select('customers.*, COUNT(transactions.id) AS transactions_count')
            .limit(5)
  end
end