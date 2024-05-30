class ChangeResultsToResult < ActiveRecord::Migration[7.1]
  def change
    rename_column :transactions, :results, :result
  end
end
