module Granz::DiscordCommands
  module Rate
    extend Discordrb::Commands::CommandContainer
    command :rate, min_args: 1 do |event, *rating|
      begin
        arr = %w[0 1 2 3 4 5 6 7 8 9 10]
        message = rating.join(" ")
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.description = "I give **#{message}** a **#{arr.sample}/10** ~#{Granz::CONFIG["$bot_name"]}"
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
