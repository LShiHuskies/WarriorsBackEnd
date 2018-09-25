class Api::MoveTwosController < ApplicationController

  def index
    render json: Move.all
  end

  def create

    ActionCable.server.broadcast 'MoveTwosChannel', {
      left: params[:left],
      top: params[:top],
      user_id: params[:user_id],
      type: params['type']
    }
    render json: {
      id: params[:user_id]
    }
  end

end
