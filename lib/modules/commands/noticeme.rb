module Granz::DiscordCommands
  module Noticeme
    extend Discordrb::Commands::CommandContainer
    command :noticeme do |event|
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.description = "#{event.user.mention}, I notice you :relaxed:"
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
