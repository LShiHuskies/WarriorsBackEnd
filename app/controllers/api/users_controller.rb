# class Api::UsersController < ApplicationController
#
#   def index
#
#     token = request.headers["Authorization"]
#
#     begin
#
#       if (decoded_token())
#         render json: User.all
#       end
#
#     rescue JWT::DecodeError
#       render json: {
#         message: 'INFO ENTERED IS WRONG!!!'
#       }, status: :unauthorized
#     end
#
#   end
#
#   def create
#     @user = User.new
#
#     @user.username = params[:username]
#     @user.password = params[:password]
#
#
#
#     if @user.save
#       render json: {
#         username: @user.username,
#         id: @user.id
#       }
#     else
#       render json: {
#         errors: @user.errors.full_messages
#       }, status: :unprocessable_entity
#     end
#   end
#
#
#   def show
#     @user = User.find_by(id: params[:id])
#
#     begin
#
#       if (decoded_token())
#         render json: @user
#       end
#
#     rescue JWT::DecodeError
#       render json: {
#         message: 'INFO ENTERED IS WRONG!!!'
#       }, status: :unauthorized
#     end
#
#   end
#
#   def update
#
#     @user = User.find_by(username: params[:username])
#     @game = Game.find_by(id: params['game_id'])
#     @user.games << @game
#
#     render json: @user.games
#   end
#
#
# end







class Api::UsersController < ApplicationController

    before_action :requires_login, only: [:index, :show, :users_games]
    before_action :is_admin, only: [:index]

  def index

    render json: User.all

  end

  def create
    @user = User.new

    @user.username = params[:username]
    @user.password = params[:password]



    if @user.save
      ActionCable.server.broadcast 'UsersChannel', {
        username: @user.username,
        id: @user.id
      }

      render json: {
        username: @user.username,
        id: @user.id
      }
      # serialized_data = ActiveModelSerializers::Adapter::Json.new(
      #   UserSerializer.new(@user)
      # ).serializable_hash
      # UsersChannel.broadcast_to @user, serialized_data
      # head :ok
    else
      render json: {
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end


  def show
    @user = User.find_by(id: params[:id])

    render json: @user

  end

  def update
    @user = User.find_by(id: params[:id])
    if params['game_id']
      @game = Game.find_by(id: params['game_id'])
      @user.games << @game
    end

    ActionCable.server.broadcast 'UsersChannel', {
      username: @user.username,
      id: @user.id,
      games: @user.games,
      character: params['character']
    }

    render json: @user.games
  end

  def users_games
    @user = User.find_by(id: params[:id])

    render json: @user.games

  end

end
