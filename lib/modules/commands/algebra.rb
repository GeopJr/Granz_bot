module Granz::DiscordCommands
  module Algebra
    extend Discordrb::Commands::CommandContainer
    command :algebra, min_args: 1 do |event, *args|
      begin
        vis = args.join("").gsub("+", "%2B").gsub("=", "%3D").gsub("/", "%2F").gsub(",", "%2C").gsub(".", "%2E")
        event.channel.send_embed do |embed|
          embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://chart.googleapis.com/chart?cht=tx&chl=#{vis}")
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
