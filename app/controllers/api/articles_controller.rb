class Api::ArticlesController < ApiController

  def index
    articles = Article.all
    render json: articles, include: :user
  end
end