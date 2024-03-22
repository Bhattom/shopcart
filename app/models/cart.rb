class Cart < ApplicationRecord
    has_many :lineitems, dependent: :destroy

    
    def add_product(product, quantity, size_id)
        current_item = lineitems.find_by(product_id: product.id)
        if current_item
            qty = current_item.quantity.to_i > 0 ? current_item.quantity.to_i + quantity.to_i : quantity.to_i
            current_item.update(quantity: qty)
        else
            current_item = lineitems.build(product_id: product.id)
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
