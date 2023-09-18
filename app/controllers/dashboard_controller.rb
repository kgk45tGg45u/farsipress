class DashboardController < ApplicationController

  def index
    # fetch_articles
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
      feed.items.each do |item|
        if item.description != ''
          sandbox = Sandbox.new(title: item.title, content: item.description, source: 'رادیو فردا')
          sandbox.save!
        end
      end
    end
    # END RADIOFARDA

    # BEGIN DW
    require 'rss'
    require 'open-uri'
    url = 'http://rss.dw-world.de/xml/rss-per_politik_volltext'
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.description != ''
          sandbox = Sandbox.new(title: item.title, content: item.description, source: 'دویچه وله')
          sandbox.save!
        end
      end
    end
    # END DW

    #BEGIN ILNA
    require 'rss'
    require 'open-uri'
    url = 'http://ilna.ir/news/rss.cfm?type=1'
    URI.open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      feed.items.each do |item|
        if item.description != ''
          sandbox = Sandbox.new(title: item.title, content: item.description, source: 'ایلنا')
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
    #     if item.description != ''
    #       sandbox = Sandbox.new(title: item.title, content: item.description, source: 'ایلنا')
    #       sandbox.save!
    #     end
    #   end
    # end
    # #END ENTEKHAB

  end
  
  sandboxall = Sandbox.all
  sandboxall.each do |sandbox|
    if sandbox.content.length > 500
      sandbox.destroy!
    end
  end

end
