class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @headern = Article.last
    @kholase = @headern.content.truncate(300, separator: ' ')
    @akhbar = Article.all
    @pishkhan = @akhbar.drop(1)
    @categories = Category.all
    @siasi = @akhbar.where(category_id: 1)
    @eghtesad = @akhbar.where(category_id: 2)
  end
end
