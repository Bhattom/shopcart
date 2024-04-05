class CheckoutController < ApplicationController

    def create
        @session = Stripe::Checkout::Session.create({
            payment_method_types: ['card'],
            line_item: [{
                name: product.name,
                price: product.price,
                currency: "inr",
                quantity: 1
            }],
            mode: 'payment',
            success_url: 'https://example.com/success',
            cancel_url:'https://example.com/cancel'
        })
    end
end
