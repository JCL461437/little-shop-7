class AddStatusToInvoiceItems < ActiveRecord::Migration[7.1]
  def change
    add_column :invoice_items, :status, :integer, default: 0
  end
end
