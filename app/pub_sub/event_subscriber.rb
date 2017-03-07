module EventSubscriber
    def register_events
        Subscriber.subscribe('order.confirmation') do |event|
            error = "Error: #{event.payload[:exception].first}" if event.payload[:exception]
            puts "#{event.transaction_id} | #{event.name} | #{event.time} | #{event.duration} | #{event.payload[:order].id} | #{error}"
            OrderMailer.delay.send_confirmation(event.payload[:order]) # delayed job
        end
    end
end
