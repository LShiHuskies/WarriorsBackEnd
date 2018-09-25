class Api::UserGamesController < ApplicationController

  def index
    render json: UserGame.all
  end

  def create
     @userGame = UserGame.new


      ActionCable.server.broadcast 'UserGamesChannel', {
        id: @userGame.id

      }
      render json: {
        id: @userGame.id
      }
    else
      render json: {
        id: @userGame.id
      }
    end

  end

end
