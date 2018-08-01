# Gems
require "discordrb"
require "json"
require "http"
require "cleverbot"
require "rest-client"
require "vigenere"
require "yaml"
# Just to stop an error from logging
ENV["DISCORDRB_NONACL"] = "libsodium is useless here"
# Bot module
module Granz
  CONFIG = YAML.load_file("config.yaml")
  #For WINDOWS
  #CONFIG = YAML.load_file("../config.yaml")
  
  # Bot connect
  $bot = Discordrb::Commands::CommandBot.new token: CONFIG["$token"], client_id: CONFIG["$client_id"], prefix: CONFIG["$prefix"], ignore_bots: true, help_command: false
  # Loads all commands and events
  def self.load_modules(klass, path)
    new_module = Module.new
    const_set(klass.to_sym, new_module)
    Dir["#{File.dirname(__FILE__)}/modules/#{path}/*.rb"].each { |file| load file }
    #For WINDOWS
    #Dir["modules/#{path}/*.rb"].each { |file| load file }
    new_module.constants.each do |mod|
      $bot.include! new_module.const_get(mod)
    end
  end
  load_modules(:DiscordEvents, "events")
  load_modules(:DiscordCommands, "commands")
  # Logs a message to your terminal
  puts "Connected"
  # No need to explain
  $bot.run :async
end
$bot.sync
