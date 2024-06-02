class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def to_dollars
    "$" + sprintf('%.2f', self.unit_price.to_f / 100)
  end
end