class FakeJob < ApplicationJob
  queue_as :default

  def perform(*args)
    sandboxall = Sandbox.all
    sandboxall.each do |item|
      tarikh = item.created_at
      today = Date.now
      if today.strftime("%Y-%m-%d").to_i - tarikh.strftime("%Y-%m-%d").to_i >= 1
        item.destroy!
      end
    end
    require 'rss'
    require 'open-uri'
    url = 'https://www.radiofarda.com/rss/'
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      puts "Title: #{feed.channel.title}"
      feed.items.each do |item|
        puts "Item: #{item.title}"
        if item.description != ''
          sandbox = Sandbox.new(title: item.title, content: item.description, source: 'Radio Farda')
          sandbox.save!
        end
      end
    end
  end
end
