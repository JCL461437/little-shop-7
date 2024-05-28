class AddResultToTransactions < ActiveRecord::Migration[7.1]
  def change
    add_column :transactions, :results, :integer
  end
end
