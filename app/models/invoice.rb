class Invoice < ApplicationRecord
	belongs_to :customer
	has_many :invoice_items
	has_many :transactions
	has_many :items, through: :invoice_items
	has_many :merchants, through: :items

	enum status: { "in progress": 0, completed: 1, cancelled: 2 }

	def self.incomplete_invoices
		incomplete = Invoice.joins(:invoice_items)
												.where("invoice_items.status != 2")
												.select("invoices.*, count(invoice_items.status) as item_status_count")
												.group("invoices.id")
		# binding.pry
	end
	
end