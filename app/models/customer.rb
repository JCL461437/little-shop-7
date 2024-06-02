class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.top_five_customers 
    # customers = Customer.joins(:transactions) - don't need the customers local variable here
    Customer.joins(:transactions)
      .where("transactions.result = 0")
      .select("customers.id, concat(customers.first_name, ' ', customers.last_name) as full_name, count(transactions.id) as count_of_purchases")
      .group("customers.id")
      .order("count_of_purchases desc")
      .limit(5)
  end
  
end