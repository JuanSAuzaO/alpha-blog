class Api::UsersController < ApiController

  def index
    users = User.all
    render json: users, include: :articles
  end
end