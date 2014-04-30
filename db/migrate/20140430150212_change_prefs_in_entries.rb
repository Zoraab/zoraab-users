class ChangePrefsInEntries < ActiveRecord::Migration
  def change
    change_column :entries, :prefs, :text
  end
end
