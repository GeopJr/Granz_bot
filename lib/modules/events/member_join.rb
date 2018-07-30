module Granz::DiscordEvents
  module Member_join
    extend Discordrb::EventContainer
    server_create do |_event|
      $bot.listening = "#{Granz::CONFIG["$prefix"]}help | in #{_event.bot.servers.count} servers"
    end
  end
end
