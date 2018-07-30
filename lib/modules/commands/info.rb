module Granz::DiscordCommands
  module Info
    extend Discordrb::Commands::CommandContainer
    command :info do |event|
      begin
        event.channel.send_embed do |embed|
          embed.title = "Some Info"
          embed.colour = 0xffff00

          embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{Granz::CONFIG["$bot_name"]}##{Granz::CONFIG["$bot_tag"]}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

          embed.add_field(name: "__Name & Avatar__", value: "Granz is a character made by Mentaiko")
          embed.add_field(name: "__Version__", value: Granz::CONFIG["$version"].to_s)
          embed.add_field(name: "__Written in__", value: "Ruby using discordrb")
          embed.add_field(name: "__Prefix__", value: Granz::CONFIG["$prefix"].to_s)
          embed.add_field(name: "__Invite Link__", value: "[HERE](https://discordapp.com/oauth2/authorize?client_id=443053627419000833&scope=bot&permissions=388190&redirect_uri=https://granz.geopjr.xyz/thanks.html&response_type=code)")
          embed.add_field(name: "__Support Server__", value: "https://discordbots.org/servers/404294934041067522")
          embed.add_field(name: "__MIT Licenced__", value: "https://github.com/GeopJr/Granz_bot")
          embed.add_field(name: "__Updates__", value: "At least 2 commands a week")
          embed.add_field(name: "__Found an error ?__", value: "<:steam:314349923044687872> [**Steam**](https://steamcommunity.com/id/geopjunior/)\n<:discord:314003252830011395> **『Geop』#4066**\n<:update:264184209617321984> **e-mail**: geopjr@geopjr.xyz")
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
