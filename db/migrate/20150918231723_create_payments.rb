class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :invoice, index: true, foreign_key: true
      t.decimal :total_payment
      t.string :notes

      t.timestamps null: false
    end
  end
end
