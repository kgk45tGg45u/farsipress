class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @headern = Article.last
    @kholase = @headern.content.truncate(300, separator: ' ')
  end
end
