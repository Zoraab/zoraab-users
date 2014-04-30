class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :recipient
      t.string :recipient_name
      t.text :gift_note
      t.string :prefs
      t.integer :qty
      t.string :payment
      t.integer :term
      t.timestamps
    end
  end
end
