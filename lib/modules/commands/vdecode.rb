module Granz::DiscordCommands
  module Vdecode
    extend Discordrb::Commands::CommandContainer
    command :vdecode, min_args: 2 do |event, key, *code|
      message = code.join(" ")
      begin
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = Vigenere.decode("#{key.upcase}", "#{message.upcase}")
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
