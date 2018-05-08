#Gems
require 'discordrb'
require 'json'
require 'cleverbot'
#Change these to whatever you want
$prefix = "Your desired prefix"
$version = "Your desired version"
$bot_name = "Your bot's Name"
$bot_tag = "Your bot's tag"
#Change these to their values
$token = "Your Bot's token"
$client_id = "Your Bot's ID"
#Don't change this
$bot = Discordrb::Commands::CommandBot.new token: $token, client_id: $client_id, prefix: $prefix
#Logs a message to your terminal
puts "Connected"
#Used for cleverbot.io , change YOUR_API_USER and YOUR_API_KEY to theur values
talk = Cleverbot.new('YOUR_API_USER', 'YOUR_API_KEY')
#help command
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
		embed.add_field(name: "#{$prefix}cookie", value: "Responds with a cookie emoji")
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
	m = event.respond('Pong!')
	m.edit "Pong! Time : #{Time.now - event.timestamp} sec."
end

$bot.message(containing: '(╯°□°）╯︵ ┻━┻') do |event|
	m =	event.respond ('┬─┬﻿ ノ( ゜-゜ノ)')
end

$bot.message do |event|
  if event.message.content.include?("<@#{$bot.profile.id}>") || event.message.content.include?("<@#{$bot.profile.id}>")
    event.channel.start_typing
    event.respond(talk.say(event.message.content.gsub("<@#{$bot.profile.id}>", '').gsub("<@!#{$bot.profile.id}>", '')))
  end
end

$bot.command :yesno do |event|
	arr = ["Yes.","No."]
	event.respond(arr.sample)
end

$bot.command :lmgtfy do |event, *args|
	event.respond "#{event.user.mention}, <http://lmgtfy.com/?q=%s>" % [args.join("+")]
end

$bot.command :avatar, min_args: 1, max_args: 1 do |event, user|
user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.respond "#{mentioned_user.mention}'s avatar is #{mentioned_user.avatar_url}"
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.respond "#{mentioned_user.mention}'s avatar is #{mentioned_user.avatar_url}"
		end
	end
end

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

$bot.command :kiss, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.respond "#{mentioned_user.mention}, #{event.user.mention} kissed you :kiss:"
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.respond "#{mentioned_user.mention}, #{event.user.mention} kissed you :kiss:"
		end
	end
end

$bot.command :hug, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.respond "#{mentioned_user.mention}, #{event.user.mention} hugged you :hugging:"
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.respond "#{mentioned_user.mention}, #{event.user.mention} hugged you :hugging:"
		end
	end
end

$bot.command :noticeme do |event|
			event.respond "#{event.user.mention}, I notice you :relaxed:"
end

$bot.command :shoot, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.respond "#{mentioned_user.mention}, shot #{event.user.mention} :gun:"
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.respond "#{mentioned_user.mention}, shot #{event.user.mention} :gun:"
		end
	end
end

$bot.command :rate, min_args: 1, max_args: 1 do |event, rating|
	arr = ["0","1","2","3","4","5","6","7","8","9","10"]
    event.respond "I give #{rating} a #{arr.sample}/10 ~#{$bot_name}"
  end
  
$bot.command :reverse,  min_args: 1 do |event, *args|
	args.join(' ').reverse
end

$bot.command :id, min_args: 1, max_args: 1 do |event, user|
	user = user[2..-2]
	begin
		mentioned_user = $bot.user(user);
		event.respond "`#{mentioned_user.mention}`"
	rescue
		begin
			user = user[1..-1]
			mentioned_user = $bot.user(user);
			event.respond "`#{mentioned_user.mention}`"
		end
	end
end

$bot.command :cookie do |event|
	event.respond ":cookie:"
end

#Playing Game
$bot.ready do |_event|
	$uptimer = Time.now
  $bot.game = "#{$prefix}help | in #{_event.bot.servers.count} servers"
end
#No need to explain
$bot.run
