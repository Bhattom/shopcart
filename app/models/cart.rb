class Cart < ApplicationRecord
    has_many :lineitems, dependent: :destroy

    
    def add_product(product, quantity, size_ids)
          current_item = lineitems.find_or_initialize_by(product_id: product.id)
          p current_item
          p "wwwwwwww"
          p "wwwwwwww"
          p "wwwwwwww"
          p "wwwwwwww"
          p "wwwwwwww"
          p "wwwwwwww"
          p "wwwwwwww"
          if current_item.persisted?
            qty = current_item.quantity.to_i > 0 ? current_item.quantity.to_i + quantity.to_i : quantity.to_i
            current_item.update(quantity: qty)
          else
            current_item = lineitems.build(product_id: product.id, size_id: size_ids, quantity: quantity)
          end

          current_item
    end

    def unit_price
        lineitems.to_a.sum {|item| item.unit_price }
    end

    def subtotal
        lineitems.to_a.sum(&:unit_price)
    end

end
