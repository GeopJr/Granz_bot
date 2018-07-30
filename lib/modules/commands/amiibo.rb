module Granz::DiscordCommands
  module Amiibo
    extend Discordrb::Commands::CommandContainer
    command :amiibo, min_args: 1, max_args: 1 do |event, name|
      begin
        url = URI.escape("http://www.amiiboapi.com/api/amiibo/?name=#{name}")
        parse = JSON.parse(RestClient.get(url))
        img = parse["amiibo"][0]["image"]
        eu = parse["amiibo"][0]["release"]["eu"]
        au = parse["amiibo"][0]["release"]["au"]
        jp = parse["amiibo"][0]["release"]["jp"]
        na = parse["amiibo"][0]["release"]["na"]

        event.channel.send_embed do |embed|
          embed.title = parse["amiibo"][0]["character"]
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{img}")
          embed.color = 0xffff00
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{Granz::CONFIG["$bot_name"]}##{Granz::CONFIG["$bot_tag"]}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

          embed.add_field(name: "__Amiibo Series__", value: parse["amiibo"][0]["amiiboSeries"])
          embed.add_field(name: "__Game Series__", value: parse["amiibo"][0]["gameSeries"])
          embed.add_field(name: "__Release Day__", value: "**AU:** #{au}\n**EU:** #{eu}\n**JP:** #{jp}\n**NA:** #{na}")
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "Not Found"
        end
      end
    end
  end
end
