class AddKindToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :kind, :integer, default: 0
  end
end
