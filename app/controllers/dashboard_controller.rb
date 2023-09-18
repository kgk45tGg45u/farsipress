class DashboardController < ApplicationController

  def index
    fetch_articles
    @sandboxes = Sandbox.all

  end

  private

  def fetch_articles
    sandboxall = Sandbox.all
    sandboxall.each do |item|
      tarikh = item.created_at
      today = Date.today
      if today.strftime("%Y-%m-%d").to_i - tarikh.strftime("%Y-%m-%d").to_i >= 1
        item.destroy!
      end
    end

    # START RADIOFARDA

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

    # END RADIO FARDA
  end


end
