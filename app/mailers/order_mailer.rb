class OrderMailer < ApplicationMailer
    def send_confirmation(order)
        @order = order
        @user = @order.user
        mail to: "meraj.enigma@gmail.com", subject: "Order Confirmation"
    end
end
