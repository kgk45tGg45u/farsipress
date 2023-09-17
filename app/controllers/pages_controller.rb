class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    require 'rss'
    require 'open-uri'
    url = 'https://www.radiofarda.com/rss/'
    URI.open(url) do |rss|
      @feed = RSS::Parser.parse(rss)
    end
  end
end
