ActiveSupport::Notifications.subscribe('render') do |*args|
    puts "event received"
end
