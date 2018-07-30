module Granz::DiscordEvents
  module Ready
    extend Discordrb::EventContainer
    ready do |_event|
      $bot.listening = "#{Granz::CONFIG["$prefix"]}help | in #{_event.bot.servers.count} servers"
      $uptimer = Time.now
    end
  end
end
