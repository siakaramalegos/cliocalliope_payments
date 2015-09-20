class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :number
      t.references :customer, index: true, foreign_key: true
      t.date :invoice_date
      t.date :due_date
      t.decimal :total_amount

      t.timestamps null: false
    end
  end
end
