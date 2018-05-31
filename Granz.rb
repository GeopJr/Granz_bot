#Gems
require 'discordrb'
require 'json'
require 'cleverbot'
require 'http'
#Change these to whatever you want
$prefix = "Your desired prefix"
$version = "Your desired version"
$bot_name = "Your bot's Name"
$bot_tag = "Your bot's tag"
#Change these to their values
$token = "Your Bot's token"
$client_id = "Your Bot's ID"
#Don't change this
$bot = Discordrb::Commands::CommandBot.new token: $token, client_id: $client_id, prefix: $prefix, ignore_bots: true
#Logs a message to your terminal
puts "Connected"
#Used for cleverbot.io , change YOUR_API_USER and YOUR_API_KEY to theur values
talk = Cleverbot.new('YOUR_API_USER', 'YOUR_API_KEY')
#Help Command
$bot.command :help do |event|
	event.channel.send_embed do |embed|
	  embed.title = "You called for help , here I am !!!"
	  embed.colour = 0xffff00

	  embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{$bot_name}#{$bot_tag}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
	  embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "『Geop』#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

	  embed.add_field(name: "Commands", value: "All Commands")
	  embed.add_field(name: "#{$prefix}help", value: "Responds with this")
	  embed.add_field(name: "#{$prefix}info", value: "Responds with info")
		embed.add_field(name: "@#{$bot_name}#{$bot_tag}", value: "Cleverbot with it")
		embed.add_field(name: "#{$prefix}avatar <mention>", value: "Responds with the avatar of the mentioned user")
		#embed.add_field(name: "#{$prefix}bara", value: "Will respond with a bara image :octagonal_sign:NSFW:octagonal_sign:")
		embed.add_field(name: "#{$prefix}bird", value: "Send a random bird picture :bird:")
		embed.add_field(name: "#{$prefix}blush", value: "Blushes :blush:")
		embed.add_field(name: "#{$prefix}cat", value: "Send a random cat picture :cat:")
		embed.add_field(name: "#{$prefix}cookie", value: "Responds with a :cookie:")
		embed.add_field(name: "#{$prefix}ddg", value: "Searches something using duckduckgo for you")
		embed.add_field(name: "#{$prefix}doge", value: "Send a random doge picture :dog:")
		embed.add_field(name: "#{$prefix}hug <mention>", value: "Hugs mentioned user")
		embed.add_field(name: "#{$prefix}id <mention>", value: "Responds with the id of the mentioned user")
		embed.add_field(name: "#{$prefix}kiss <mention>", value: "Kisses mentioned user")
		embed.add_field(name: "#{$prefix}lmgtfy", value: "Google's something for you")
		embed.add_field(name: "#{$prefix}noticeme", value: "Notices you")
		embed.add_field(name: "#{$prefix}ping", value: "Responds with Pong!")
		embed.add_field(name: "#{$prefix}rate <something>", value: "Rates Something")
		embed.add_field(name: "#{$prefix}reverse <something>", value: "Responds with the reversed version of something")
		embed.add_field(name: "#{$prefix}shoot <mention>", value: "Shoots mentioned user")
		embed.add_field(name: "#{$prefix}uptime", value: "Responds with bot's uptime")
		embed.add_field(name: "#{$prefix}yesno", value: "Responds with yes or no to a question")
	end
end
#Info
$bot.command :info do |event|
	event.channel.send_embed do |embed|
	  embed.title = "Some Info"
	  embed.colour = 0xffff00

	  embed.author = Discordrb::Webhooks::EmbedAuthor.new(name: "#{$bot_name}#{$bot_tag}", icon_url: "https://cdn.discordapp.com/avatars/443053627419000833/0da891379e4d9d7af31b27ec67c49a3b.png")
	  embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "『Geop』#4066", icon_url: "https://cdn.discordapp.com/avatars/216156825978929152/4726ea8789285323ca03e995b9a059bf.png")

	  embed.add_field(name: "Name & Avatar", value: "Granz is a character made by Mentaiko")
	  embed.add_field(name: "Version", value: "#{$version}")
	  embed.add_field(name: "Written in", value: "Ruby using discordrb")
		embed.add_field(name: "Prefix", value: "#{$prefix}")
		embed.add_field(name: "Invite Link", value: "https://discordapp.com/oauth2/authorize?client_id=#{$client_id}&scope=bot&permissions=103894080")
		embed.add_field(name: "MIT Licenced", value: "https://github.com/GeopJr/Granz_bot")
		embed.add_field(name: "Updates", value: "At least 2 commands a week")
	end
end
#Commands
$bot.command :ping do |event|
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = ":ping_pong: Pong! (#{Time.now - event.timestamp} sec.)"
	end
end
#Replaces tableflip with put the damn table sown
$bot.message(containing: '(╯°□°）╯︵ ┻━┻') do |event|
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = '┬─┬﻿ ノ( ゜-゜ノ)'
	end
end
#Cleverbot
$bot.message do |event|
  if event.message.content.start_with?("<@#{$bot.profile.id}>") || event.message.content.start_with?("<@#{$bot.profile.id}>")
    event.channel.start_typing
		event.channel.send_embed do |embed|
		embed.colour = 0xffff00
		embed.title = talk.say(event.message.content.gsub("<@#{$bot.profile.id}>", '').gsub("<@!#{$bot.profile.id}>", ''))
		embed.description = "Replying to : #{event.user.mention}"
		end
  end
end
#Answers yes or no
$bot.command :yesno, min_args: 1 do |event|
	arr = ["Yes.","No."]
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = "#{arr.sample}"
	end
end
#Generates a let me google that for you link
$bot.command :lmgtfy do |event, *args|
event.respond "#{event.user.mention},"
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = "<http://lmgtfy.com/?q=%s>" % [args.join("+")]
	end
end
#Generates a duckduckgo link
$bot.command :ddg do |event, *args|
event.respond "#{event.user.mention},"
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = "<http://duckduckgo.com/%s?ia=web>" % [args.join("%20")]
	end
end
#Responds with the avatar of the tagged user
$bot.command :avatar, min_args: 1, max_args: 1 do |event, user|
user = user[2..-2]
	begin
			mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{mentioned_user.avatar_url}?size=1024")
end
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.image = Discordrb::Webhooks::EmbedImage.new(url: "#{mentioned_user.avatar_url}?size=1024")
			end
		end
	end
end
#Shows the uptime
$bot.command :uptime do |event|
	full_sec = Time.now - $uptimer
	sec = full_sec % 60
	min = full_sec / 60
	sec = sec.floor
	min = min.floor
	event.channel.send_embed do |embed|
		embed.title = 'Uptime:'
		embed.description = '%s minutes and %s seconds' % [min, sec]
		embed.colour = 0xffff00
	end
end
#Kisses tagged user
$bot.command :kiss, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.channel.send_embed do |embed|
		embed.colour = 0xffff00
		embed.description = "#{mentioned_user.mention}, #{event.user.mention} kissed you :kiss:"
		end
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.description = "#{mentioned_user.mention}, #{event.user.mention} kissed you :kiss:"
			end
		end
	end
end
#Hugs tagged user
$bot.command :hug, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.channel.send_embed do |embed|
		embed.colour = 0xffff00
		embed.description = "#{mentioned_user.mention}, #{event.user.mention} hugged you :hugging:"
			end
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.description = "#{mentioned_user.mention}, #{event.user.mention} hugged you :hugging:"
			end
		end
	end
end
#Notices you
$bot.command :noticeme do |event|
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.description = "#{event.user.mention}, I notice you :relaxed:"
	end
end
#Blushes
$bot.command :blush do |event|
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.image = Discordrb::Webhooks::EmbedImage.new(url: "https://i.imgur.com/fIY6c7d.png")
	end
end
#Shoots tagged user
$bot.command :shoot, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.channel.send_embed do |embed|
		embed.colour = 0xffff00
		embed.description = "#{mentioned_user.mention}, #{event.user.mention} shot you :gun:"
		end
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.description = "#{mentioned_user.mention}, #{event.user.mention} shot you :gun:"
			end
		end
	end
end
#Rates something
$bot.command :rate, min_args: 1, max_args: 1 do |event, rating|
	arr = ["0","1","2","3","4","5","6","7","8","9","10"]
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = "I give #{rating} a #{arr.sample}/10 ~#{$bot_name}"
	end
  end
#Reverses something
$bot.command :reverse,  min_args: 1 do |event, *args|
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = "#{args.join(' ').reverse}"
	end
end
#Responds with the id of the tagged user
$bot.command :id, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.title = "#{mentioned_user.mention}"
	end
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.channel.send_embed do |embed|
			embed.colour = 0xffff00
			embed.title = "#{mentioned_user.mention}"
			end
		end
	end
end

#Responds with a random dog
$bot.command :doge do |event|
  event.channel.send_embed do |embed|
  embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get('http://shibe.online/api/shibes?count=1').parse[0])
  embed.color = 0xffff00
  end
end

#Responds with a random cat
$bot.command :cat do |event|
  event.channel.send_embed do |embed|
  embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get('http://shibe.online/api/cats?count=1').parse[0])
  embed.color = 0xffff00
   end
 end

#Responds with a random bird
$bot.command :bird do |event|
  event.channel.send_embed do |embed|
  embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get('http://shibe.online/api/birds?count=1').parse[0])
  embed.color = 0xffff00
   end
end

=begin
#Responds with a bara image
$bot.command :bara do |event|
next event.respond "I'm sorry. I can't do that because this is a SFW channel." unless event.channel.nsfw
  event.channel.send_embed do |embed|
  embed.footer = Discordrb::Webhooks::EmbedFooter.new(text: "https://barapi.geopjr.de/")
  embed.image = Discordrb::Webhooks::EmbedImage.new(url: HTTP.get('https://barapi.geopjr.de/api/random.php').parse[0])
  embed.color = 0xffff00
  end
end
=end

#Responses with a cookie
$bot.command :cookie do |event|
	event.channel.send_embed do |embed|
	embed.colour = 0xffff00
	embed.title = ":cookie:"
	end
end

=begin
$bot.command :eval do |event, *code|
break unless event.user.id == YOUR_ID
	begin
        eval code.join(' ')
	rescue => e
        "Forgive me for I have sinned :pensive: ```#{e}```"
	end
end

$bot.command :restart do |event|
break unless event.user.id == YOUR_ID
$bot.stop
exit
end
=end

#Playing Game
$bot.ready do |_event|
	$uptimer = Time.now
  $bot.game = "#{$prefix}help | in #{_event.bot.servers.count} servers"
end
#No need to explain
$bot.run
