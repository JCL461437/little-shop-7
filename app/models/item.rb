class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  enum status: {disabled: 0, enabled: 1}

  def self.enabled_items
    Item.where(status: [:enabled])
  end

  def self.disabled_items
    Item.where(status: [:disabled])
  end
end