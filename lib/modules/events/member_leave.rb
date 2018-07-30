module Granz::DiscordEvents
  module Member_leave
    extend Discordrb::EventContainer
    server_delete do |_event|
      $bot.listening = "#{Granz::CONFIG["$prefix"]}help | in #{_event.bot.servers.count} servers"
    end
  end
end
