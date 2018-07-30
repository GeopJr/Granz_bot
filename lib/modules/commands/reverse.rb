module Granz::DiscordCommands
  module Reverse
    extend Discordrb::Commands::CommandContainer
    command :reverse, min_args: 1 do |event, *args|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = args.join(" ").reverse.to_s
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
