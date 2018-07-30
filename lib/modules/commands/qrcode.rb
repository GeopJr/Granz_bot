module Granz::DiscordCommands
  module Qrcode
    extend Discordrb::Commands::CommandContainer
    command :qrcode, min_args: 1 do |event, *args|
      begin
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://chart.googleapis.com/chart?cht=qr&chs=512x512&chl=#{args.join("+")}")
          embed.color = 0xffff00
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
