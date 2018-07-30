module Granz::DiscordCommands
  module Choose
    extend Discordrb::Commands::CommandContainer
    command :choose, min_args: 2 do |event, *choices|
      begin
        arr = choices
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Hmm, I pick :"
          embed.description = "#{arr.sample}"
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
