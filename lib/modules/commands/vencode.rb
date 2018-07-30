module Granz::DiscordCommands
  module Vencode
    extend Discordrb::Commands::CommandContainer
    command :vencode, min_args: 2 do |event, key, *text|
      message = text.join(" ")
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = Vigenere.encode("#{key.upcase}", "#{message.upcase}")
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
