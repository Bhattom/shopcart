class Cart < ApplicationRecord
    has_many :lineitems, dependent: :destroy
    has_many :orders
    
    
    def add_product(product, quantity, size_ids)
        size_ids = Array(size_ids)
        size_ids.each do |size_id|
          current_item = lineitems.find_or_initialize_by(product_id: product.id)
            lineitem_size = current_item.lineitem_sizes.find_or_initialize_by(size_id: size_id)
            lineitem_size.update(quantity: quantity)
          if current_item.persisted?
            qty = current_item.quantity.to_i > 0 ? current_item.quantity.to_i + quantity.to_i : quantity.to_i
            current_item.update(quantity: qty)
            
            stk = lineitem_size.quantity.to_i > 0 ? lineitem_size.quantity.to_i + quantity.to_i : quantity.to_i
            lineitem_size.update(quantity: stk)
          else
            current_item = lineitems.build(product_id: product.id, size_id: size_ids, quantity: quantity)
          end
          current_item
        end
    end

    def unit_price
        lineitems.to_a.sum {|item| item.unit_price }
    end

    def subtotal
        lineitems.to_a.sum(&:unit_price)
    end

end
