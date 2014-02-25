class CombineItemsInCart < ActiveRecord::Migration
  def change
    # Nahrazení vívce položek jednoho produktu jednou větší položkou
    Cart.all.each do |cart|
      # spočítej počet každého produktu v košíku
      sums = cart.line_items.group(:product_id).sum(:quantity)
      
      sums.each do |product_id, quantity|
        if quantity > 1
          # odebrání samostantých položek
          cart.line_items.where(:product_id => product_id).delete_all
          
          # nahrazení jednotnou položkou
          cart.line_items.create(:product_id => product_id, :quantity => quantity)
        end
      end
    end
  end
end
