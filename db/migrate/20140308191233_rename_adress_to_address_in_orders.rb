class RenameAdressToAddressInOrders < ActiveRecord::Migration
  def change
    rename_column 'orders', 'adress', 'address' 
  end
end
