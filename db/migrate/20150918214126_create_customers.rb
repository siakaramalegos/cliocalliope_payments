class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :contact_name
      t.string :email

      t.timestamps null: false
    end
  end
end
