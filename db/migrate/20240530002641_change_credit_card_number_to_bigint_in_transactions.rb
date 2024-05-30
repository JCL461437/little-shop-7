class ChangeCreditCardNumberToBigintInTransactions < ActiveRecord::Migration[7.1]
  def change
    change_column :transactions, :credit_card_number, :bigint
  end
end
