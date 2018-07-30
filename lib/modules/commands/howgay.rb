module Granz::DiscordCommands
  module Howgay
    extend Discordrb::Commands::CommandContainer
    command :howgay, min_args: 1 do |event, *rating|
      begin
        arr = (0..100).to_a
        message = rating.join(" ")
        event.channel.send_embed do |embed|
          embed.title = "How much of a homosexual are you ?"
          embed.colour = 0xffff00
          embed.description = "**#{message}** is **#{arr.sample}/100** homosexual :gay_pride_flag:"
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
