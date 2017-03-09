#! /usr/bin/env ruby
require 'trello'
require 'dotenv/load'
require 'pry'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY']
  config.member_token = ENV['TRELLO_MEMBER_TOKEN']
end

board_id = ARGV[0]
if board_id.nil?
  STDERR.puts 'no board id'
  exit 1
end

board = Trello::Board.find(board_id)
board.lists.each do |list|
  puts "# #{list.name}"
  puts
  list.cards.each do |card|
    puts "* #{card.name}"
    card.comments.each do |comment|
      puts "  * #{comment.text.gsub("\n", '<br>')}"
    end
  end
  puts
end
