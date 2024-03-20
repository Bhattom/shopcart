module ApplicationHelper

    def cart_count_over_one
        if @cart.lineitems.count > 0 
            return "<span class='tag is-dark'>#{@cart.lineitems.count}</span>".html_safe
        end
    end

    def cart_has_item
        return @cart.lineitems.count > 0
    end
end
