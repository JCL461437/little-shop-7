class AddStatusToMerchants < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :status, :integer, default: 0, null: false
  end
end
