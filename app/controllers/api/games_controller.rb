# class Api::GamesController < ApplicationController
#
#   def index
#
#     token = request.headers["Authorization"]
#
#     begin
#       decoded_token = decoded_token()
#       render json: Game.all
#     rescue
#       # JWT::DecodeError
#       render json: {
#         message: 'INFO ENTERED IS WRONG!!!'
#       }, status: :unauthorized
#     end
#
#   end
#
#   def create
#     @game = Game.new
#
#     @game.scores = params[:scores]
#
#     if @game.save
#       render json: {
#         scores: @game.scores,
#         id: @game.id
#     }
#     else
#       render json: {
#         errors: @game.errors.full_messages
#       }, status: :unprocessable_entity
#     end
#
#   end
#
#
#   def show
#     @game = Game.find_by(id: params[:id])
#
#     begin
#
#       if (decoded_token())
#         render json: @game
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
# end





class Api::GamesController < ApplicationController

  before_action :requires_login, only: [:index]



  def index

    # token = request.headers["Authorization"]

    # authenticate(Game.all)

    # if !valid_token?
    #   render json: {
    #     message: 'INFO ENTERED IS WRONG!!!'
    #   }, status: :unauthorized
    # else
    #   render json: Game.all
    # end
    #
    # requires_login()
    render json: Game.all

  end

  def create
    

    @game = Game.new
    # @user = User.find_by(id: params[:user][:id])
    # @game.users << @user
    # @game.scores = params[:scores]

    if @game.save

    # @user = User.find_by(id: params[:user][:id])
    # @game.users << @user
    # serialized_data = ActiveModelSerializers::Adapter::Json.new(
    #   GameSerializer.new(@game)
    # ).serializable_hash
    ActionCable.server.broadcast 'GamesChannel', {
      id: @game.id
      # users: @user
    }

    render json: {
      id: @game.id
    }

    else
      render json: {
        errors: @game.errors.full_messages
      }, status: :unprocessable_entity
    end

  end


  def show
    @game = Game.find_by(id: params[:id])

    render json: @game

  end


  def update

    @game = Game.find_by(id: params[:id])
    if params['scores']
      @game.scores = params['scores']
    end
    if params['username']
      @user = User.find_by(username: params['username'])
      @game.users << @user
    end
    if params['otherUserName']
      @otherUser = User.find_by(username: params['otherUserName']['username'])
      @game.users << @otherUser
    end
    @game.save

    ActionCable.server.broadcast 'GamesChannel', {
      scores: params['scores']
    }
    render json: @game

  end

end
