class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.references :invoice, null: false, foreign_key: true
      t.integer :credit_card_number
      t.string :credit_card_expiration_date

      t.timestamps
    end
  end
end
