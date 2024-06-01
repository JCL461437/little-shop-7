class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def top_five_customers 
    customers = Customer.joins(:transactions)
      .where("transactions.result = 0")
      .select("customers.*, count(transactions.id) as count_of_purchases")
      .group("customers.id")
      .order("count_of_purchases desc")
      .limit(5)

    binding.pry

  end


  
end