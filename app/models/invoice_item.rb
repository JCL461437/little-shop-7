class InvoiceItem < ApplicationRecord
  belongs_to :items
  belongs_to :invoices
  enum status: { pending: 0, packaged: 1, shipped: 2 }
end