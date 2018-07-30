module Granz::DiscordCommands
  module Uptime
    extend Discordrb::Commands::CommandContainer
    command :uptime do |event|
      full_sec = Time.now - $uptimer
      sec = full_sec % 60
      min = full_sec / 60
      sec = sec.floor
      min = min.floor
      begin
        event.channel.send_embed do |embed|
          embed.title = "Uptime:"
          embed.description = format("%s minutes and %s seconds", min, sec)
          embed.colour = 0xffff00
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Error"
        end
      end
    end
  end
end
