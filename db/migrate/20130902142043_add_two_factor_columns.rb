class AddTwoFactorColumns < ActiveRecord::Migration
  def change
    add_column :users, :pin, :string
    add_column :users, :phone, :string
  end
end
