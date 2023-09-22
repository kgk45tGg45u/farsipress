class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @headern = Article.last
    @kholase = @headern.content.truncate(300, separator: ' ')
    @akhbar = Article.all
    @pishkhan = @akhbar.drop(1)
    @categories = Category.all
    # @akhabrebakhsh = @akhbar.where(category = category.name)
  end
end
