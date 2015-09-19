class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.references :customer, index: true, foreign_key: true
      t.string :fingerprint

      t.timestamps null: false
    end
  end
end
