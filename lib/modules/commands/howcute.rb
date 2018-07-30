module Granz::DiscordCommands
  module Howcute
    extend Discordrb::Commands::CommandContainer
    command :howcute, min_args: 1 do |event, *rating|
      begin
        arr = (0..100).to_a
        message = rating.join(" ")
        event.channel.send_embed do |embed|
          embed.title = "How cute are you ?"
          embed.colour = 0xffff00
          embed.description = "**#{message}** is **#{arr.sample}/100** cute :blush:"
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
