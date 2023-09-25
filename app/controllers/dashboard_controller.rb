class DashboardController < ApplicationController

  def index
    fetch_articles
    @sandboxes = Sandbox.all
  end

  def show
    @sandbox = Sandbox.find(params[:id])
  end

  private

  def fetch_articles
    sandboxall = Sandbox.all
    sandboxall.each do |item|
      tarikh = item.created_at
      today = Date.today
      if (today - tarikh.to_date).to_i >= 1
        item.destroy!
      end
    end

    # START RADIOFARDA
    require 'rss'
    require 'open-uri'
    url = 'https://www.radiofarda.com/rss/'
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.description != '' && !item.enclosure.nil?
          sandbox = Sandbox.new(title: item.title, content: item.description, source: 'رادیو فردا', photo_url: item.enclosure.url, date: item.pubDate)
          sandbox.save!
        end
      end
    end
    # END RADIOFARDA

    # BEGIN ISNA
    # require 'rss'
    # require 'open-uri'
    # url = 'http://isna.ir/fa/all/feed'
    # URI.open(url) do |rss|
    #   feed = RSS::Parser.parse(rss)
    #   feed.items.each do |item|
    #     if item.description != '' && !item.enclosure.nil?
    #       sandbox = Sandbox.new(title: item.title, content: item.description, source: 'ایسنا')
    #       sandbox.save!
    #     end
    #   end
    # end
    # END ISNA

    #BEGIN ILNA
    require 'rss'
    require 'open-uri'
    url = 'http://ilna.ir/news/rss.cfm?type=1'
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.description != '' && !item.enclosure.nil?
          sandbox = Sandbox.new(title: item.title, content: item.description, source: 'ایلنا', photo_url: item.enclosure.url, date: item.pubDate)
          sandbox.save!
        end
      end
    end
    #END ILNA

    # #BEGIN ENTEKHAB
    # require 'rss'
    # require 'open-uri'
    # url = 'http://www.entekhab.ir/fa/rss/allnews'
    # URI.open(url) do |rss|
    #   feed = RSS::Parser.parse(rss)
    #   feed.items.each do |item|
    #     if item.description != '' && !item.enclosure.nil?
    #       sandbox = Sandbox.new(title: item.title, content: item.description, source: 'ایلنا')
    #       sandbox.save!
    #     end
    #   end
    # end
    # #END ENTEKHAB

  end

  sandboxall = Sandbox.all
  sandboxall.each do |sandbox|
    if sandbox.content.length > 500 || sandbox.content.length < 100
      sandbox.destroy!
    end
  end

end
