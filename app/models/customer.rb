class Customer < ApplicationRecord
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def top_five_customers 
    Customer.joins
  end
  
end

  #ACJ
  # def top_5_customers
  #   top_5 = Customer.joins(:transactions).where(transactions: { result: 0}).group(:id).count

  #   #want it to return a 
  # # end

  # Customer.joins(:transactions).where(transactions: { result: 0}).select("customers.name, COUNT(transactions.id) AS purchases_count").group("customers.id, customers.name").to_sql

  # SELECT customers.name, COUNT(transactions.id) AS purchases_count FROM "customers" INNER JOIN "invoices" ON "invoices"."customer_id" = "customers"."id" INNER JOIN "transactions" ON "transactions"."invoice_id" = "invoices"."id" WHERE "transactions"."result" = 0 GROUP BY customers.id, customers.name