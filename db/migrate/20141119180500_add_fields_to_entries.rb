class AddFieldsToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :name, :string
    add_column :entries, :email, :string
    add_column :entries, :sub_type, :string
  end
end
