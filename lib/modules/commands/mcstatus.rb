module Granz::DiscordCommands
  module Mcstatus
    extend Discordrb::Commands::CommandContainer
    command :mcstatus do |event|
      url = URI.escape("https://status.mojang.com/check")
      parse = JSON.parse(RestClient.get(url))
      if parse[0]["minecraft.net"] == "green"
        minecraft = "<:check:314349398811475968>"
      elsif parse[0]["minecraft.net"] == "yellow"
        minecraft = ":warning:"
      else
        minecraft = "<:xmark:314349398824058880>"
      end
      if parse[1]["session.minecraft.net"] == "green"
        session = "<:check:314349398811475968>"
      elsif parse[1]["session.minecraft.net"] == "yellow"
        session = ":warning:"
      else
        session = "<:xmark:314349398824058880>"
      end
      if parse[2]["account.mojang.com"] == "green"
        acc = "<:check:314349398811475968>"
      elsif parse[2]["account.mojang.com"] == "yellow"
        acc = ":warning:"
      else
        acc = "<:xmark:314349398824058880>"
      end
      if parse[3]["authserver.mojang.com"] == "green"
        aserv = "<:check:314349398811475968>"
      elsif parse[3]["authserver.mojang.com"] == "yellow"
        aserv = ":warning:"
      else
        aserv = "<:xmark:314349398824058880>"
      end
      if parse[4]["sessionserver.mojang.com"] == "green"
        sserv = "<:check:314349398811475968>"
      elsif parse[4]["sessionserver.mojang.com"] == "yellow"
        sserv = ":warning:"
      else
        sserv = "<:xmark:314349398824058880>"
      end
      if parse[5]["api.mojang.com"] == "green"
        api = "<:check:314349398811475968>"
      elsif parse[5]["api.mojang.com"] == "yellow"
        api = ":warning:"
      else
        api = "<:xmark:314349398824058880>"
      end
      if parse[6]["textures.minecraft.net"] == "green"
        textures = "<:check:314349398811475968>"
      elsif parse[6]["textures.minecraft.net"] == "yellow"
        textures = ":warning:"
      else
        textures = "<:xmark:314349398824058880>"
      end
      if parse[7]["mojang.com"] == "green"
        moj = "<:check:314349398811475968>"
      elsif parse[7]["mojang.com"] == "yellow"
        moj = ":warning:"
      else
        moj = "<:xmark:314349398824058880>"
      end
      event.channel.send_embed do |embed|
        embed.colour = 0xffff00
        embed.title = "Minecraft Status"
        embed.add_field(name: "__Minecraft.net__", value: "#{minecraft}")
        embed.add_field(name: "__Sessions__", value: "#{session}")
        embed.add_field(name: "__Accounts__", value: "#{acc}")
        embed.add_field(name: "__Auth Server__", value: "#{aserv}")
        embed.add_field(name: "__Session Server__", value: "#{sserv}")
        embed.add_field(name: "__API__", value: "#{api}")
        embed.add_field(name: "__Textures__", value: "#{textures}")
        embed.add_field(name: "__Mojang.com__", value: "#{moj}")
      end
    end
  end
end
