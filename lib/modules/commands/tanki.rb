module Granz::DiscordCommands
  module Tanki
    extend Discordrb::Commands::CommandContainer
    command :tanki, min_args: 1, max_args: 1 do |event, nick|
      begin
        url = URI.escape("http://ratings.tankionline.com/get_stat/profile/?user=#{nick}&lang=en")
        parse = JSON.parse(RestClient.get(url))
        if parse["response"]["rank"] == 1
          rank = "Recruit"
          rimg = "https://i.imgur.com/ZcBNexc.png"
        elsif parse["response"]["rank"] == 2
          rank = "Private"
          rimg = "https://i.imgur.com/Jaar0MF.png"
        elsif parse["response"]["rank"] == 3
          rank = "Gefreiter"
          rimg = "https://i.imgur.com/j2DfBdW.png"
        elsif parse["response"]["rank"] == 4
          rank = "Corporal"
          rimg = "https://i.imgur.com/7Pn4X88.png"
        elsif parse["response"]["rank"] == 5
          rank = "Master Corporal"
          rimg = "https://i.imgur.com/WKZ0sVp.png"
        elsif parse["response"]["rank"] == 6
          rank = "Sergeant"
          rimg = "https://i.imgur.com/O2WuJAJ.png"
        elsif parse["response"]["rank"] == 7
          rank = "Staff Sergeant"
          rimg = "https://i.imgur.com/bTQLm9h.png"
        elsif parse["response"]["rank"] == 8
          rank = "Master Sergeant"
          rimg = "https://i.imgur.com/VvivZg0.png"
        elsif parse["response"]["rank"] == 9
          rank = "First Sergeant"
          rimg = "https://i.imgur.com/rCkln3K.png"
        elsif parse["response"]["rank"] == 10
          rank = "Sergeant-Major"
          rimg = "https://i.imgur.com/xCKvB2G.png"
        elsif parse["response"]["rank"] == 11
          rank = "Warrant Officer 1"
          rimg = "https://i.imgur.com/TJKJ4eB.png"
        elsif parse["response"]["rank"] == 12
          rank = "Warrant Officer 2"
          rimg = "https://i.imgur.com/Q8U5QIz.png"
        elsif parse["response"]["rank"] == 13
          rank = "Warrant Officer 3"
          rimg = "https://i.imgur.com/Ygi65T7.png"
        elsif parse["response"]["rank"] == 14
          rank = "Warrant Officer 4"
          rimg = "https://i.imgur.com/rx0zDOR.png"
        elsif parse["response"]["rank"] == 15
          rank = "Warrant Officer 5"
          rimg = "https://i.imgur.com/jDmMo5j.png"
        elsif parse["response"]["rank"] == 16
          rank = "Third Lieutenant"
          rimg = "https://i.imgur.com/LLvlTZY.png"
        elsif parse["response"]["rank"] == 17
          rank = "Second Lieutenant"
          rimg = "https://i.imgur.com/1Oor2V6.png"
        elsif parse["response"]["rank"] == 18
          rank = "First Lieutenant"
          rimg = "https://i.imgur.com/03s6YiZ.png"
        elsif parse["response"]["rank"] == 19
          rank = "Captain"
          rimg = "https://i.imgur.com/kf8Uo7U.png"
        elsif parse["response"]["rank"] == 20
          rank = "Major"
          rimg = "https://i.imgur.com/Zl9q3rP.png"
        elsif parse["response"]["rank"] == 21
          rank = "Lieutenant Colonel"
          rimg = "https://i.imgur.com/bmTEps1.png"
        elsif parse["response"]["rank"] == 22
          rank = "Colonel"
          rimg = "https://i.imgur.com/Ac9S6w7.png"
        elsif parse["response"]["rank"] == 23
          rank = "Brigadier"
          rimg = "https://i.imgur.com/vBo95NA.png"
        elsif parse["response"]["rank"] == 24
          rank = "Major General"
          rimg = "https://i.imgur.com/YOuPegl.png"
        elsif parse["response"]["rank"] == 25
          rank = "Lieutenant General"
          rimg = "https://i.imgur.com/dYh43EF.png"
        elsif parse["response"]["rank"] == 26
          rank = "General"
          rimg = "https://i.imgur.com/59NrDOX.png"
        elsif parse["response"]["rank"] == 27
          rank = "Marshal"
          rimg = "https://i.imgur.com/S4smUqx.png"
        elsif parse["response"]["rank"] == 28
          rank = "Field Marshal"
          rimg = "https://i.imgur.com/DRmWUfj.png"
        elsif parse["response"]["rank"] == 29
          rank = "Commander"
          rimg = "https://i.imgur.com/lZu9Rqt.png"
        elsif parse["response"]["rank"] == 30
          rank = "Generalissimo"
          rimg = "https://i.imgur.com/Fggz9xh.png"
        elsif parse["response"]["rank"] > 31
          numrank = parse["response"]["rank"] - 30
          rank = "Legend #{numrank}"
          rimg = "https://i.imgur.com/NahcZQ9.png"
        else parse["response"]["rank"] == 31
          rank = "Legend"
          rimg = "https://i.imgur.com/NahcZQ9.png"         end

        exp = parse["response"]["score"]
        expc = parse["response"]["scoreNext"]
        nex = parse["response"]["scoreNext"] - parse["response"]["score"]
        if parse["response"]["hasPremium"] == false
          prem = "<:xmark:314349398824058880>"
        else parse["response"]["hasPremium"] == true
          prem = "<:check:314349398811475968>"         end
        crys = parse["response"]["earnedCrystals"]
        gold = parse["response"]["caughtGolds"]
        kills = parse["response"]["kills"]
        deaths = parse["response"]["deaths"]
        kd = kills.to_f / deaths
        if parse["response"]["rating"]["efficiency"]["position"] == -1
          eplac = "-"
        else
          eplac = parse["response"]["rating"]["efficiency"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["efficiency"]["value"] == -1
          evalu = "-"
        else
          evalu = parse["response"]["rating"]["efficiency"]["value"].round(-2).to_s.chomp("00").chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["score"]["position"] == -1
          explac = "-"
        else
          explac = parse["response"]["rating"]["score"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["score"]["value"] == -1
          exvalu = "-"
        else
          exvalu = parse["response"]["rating"]["score"]["value"].to_s.chomp("00").chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["golds"]["position"] == -1
          gplac = "-"
        else
          gplac = parse["response"]["rating"]["golds"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["golds"]["value"] == -1
          gvalu = "-"
        else
          gvalu = parse["response"]["rating"]["golds"]["value"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["crystals"]["position"] == -1
          cryplac = "-"
        else
          cryplac = parse["response"]["rating"]["crystals"]["position"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        if parse["response"]["rating"]["crystals"]["value"] == -1
          cryvalu = "-"
        else
          cryvalu = parse["response"]["rating"]["crystals"]["value"].to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse
        end
        
        mines = parse["response"]["suppliesUsage"][0]["usages"]
        repair = parse["response"]["suppliesUsage"][1]["usages"]
        golbo = parse["response"]["suppliesUsage"][2]["usages"]
        darm = parse["response"]["suppliesUsage"][3]["usages"]
        spebo = parse["response"]["suppliesUsage"][4]["usages"]
        ddu = parse["response"]["suppliesUsage"][5]["usages"]
        bu = parse["response"]["suppliesUsage"][6]["usages"]

        event.channel.send_embed do |embed|
          embed.title = "Stats of #{nick}"
          embed.url = "http://ratings.tankionline.com/en/user/#{nick}/"
          embed.thumbnail = Discordrb::Webhooks::EmbedThumbnail.new(url: "#{rimg}")
          embed.color = 0xffff00
          embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{Granz::CONFIG["$bot_name"]}##{Granz::CONFIG["$bot_tag"]}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
          embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "\xE3\x80\x8EGeop\xE3\x80\x8F#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

          embed.add_field(name: "__Name__", value: parse["response"]["name"])
          embed.add_field(name: "__Rank__", value: "#{rank}")
          embed.add_field(name: "__Premium__", value: "#{prem}")
          embed.add_field(name: "__EXP__", value: "#{exp.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}/#{expc.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}")
          embed.add_field(name: "__EXP left to rank up__", value: "#{nex.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse} exp")
          embed.add_field(name: "__Caught Golden Boxes__", value: "#{gold.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}")
          embed.add_field(name: "__Obtained Crystals__", value: "#{crys.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}")
          embed.add_field(name: "__Kills__", value: "#{kills.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Deaths__", value: "#{deaths.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__K/D Ratio__", value: "#{kd.round(2)}", inline: true)
          embed.add_field(name: "__Efficiency Rating Place | Value__", value: "#{eplac} | #{evalu}")
          embed.add_field(name: "__Experience Rating Place | Value__", value: "#{explac} | #{exvalu}")
          embed.add_field(name: "__Gold Box Rating Place | Value__", value: "#{gplac} | #{gvalu}")
          embed.add_field(name: "__Crystals Rating Place | Value__", value: "#{cryplac} | #{cryvalu}")
          embed.add_field(name: "__Mines Used__", value: "#{mines.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Repair Kits Used__", value: "#{repair.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Gold Boxes Used__", value: "#{golbo.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Double Armors Used__", value: "#{darm.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Speed Boosts__", value: "#{spebo.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Double Damage Used__", value: "#{ddu.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
          embed.add_field(name: "__Batteries Used__", value: "#{bu.to_s.chars.to_a.reverse.each_slice(3).map(&:join).join(",").reverse}", inline: true)
        end
      rescue
        event.channel.send_embed do |embed|
          embed.colour = 0xffff00
          embed.title = "I am afraid there is not such user in existance"
        end
      end
    end
  end
end
