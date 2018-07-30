module Granz::DiscordCommands
  module Uppercase
    extend Discordrb::Commands::CommandContainer
    command :uppercase, min_args: 1 do |event, *args|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "#{args.join(" ").upcase}"
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
