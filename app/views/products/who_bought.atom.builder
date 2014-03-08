atom_feed do |feed|
  feed.title "Kdo zakoupil #{ @product.title }"
  
  latest_order = @product.orders.sort_by(&:updated_at).last
  feed.updated(latest_order && latest_order.updated_at)
  
  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Obj. #{order.id}"
      entry.summary type: 'xhtml' do |xhtml|
        xhtml.p "Adresa: #{order.address}"
        
        xhtml.table do
          xhtml.tr do
            xhtml.th 'Produkt'
            xhtml.th 'Mn.'
            xhtml.th 'Celk. cena'
          end
          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.product.title
              xhtml.td item.quantity
              xhtml.td number_to_currency item.total_price, :locale => :cs
            end
          end
          xhtml.tr do
            xhtml.th 'celkem', :colspan => 2
            xhtml.th number_to_currency order.line_items.map(&:total_price).sum, :locale => :cs
          end
        end
        
        xhtml.p "Zp. platby: #{order.pay_type}"
      end
      entry.autor do |autor|
        entry.name order.name
        entry.email order.email
      end
    end
  end
end
