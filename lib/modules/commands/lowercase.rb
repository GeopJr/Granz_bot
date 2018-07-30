module Granz::DiscordCommands
  module Lowercase
    extend Discordrb::Commands::CommandContainer
    command :lowercase, min_args: 1 do |event, *args|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "#{args.join(" ").downcase}"
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
