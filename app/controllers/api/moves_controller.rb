class Api::MovesController < ApplicationController

  def index
    render json: Move.all
  end

  # def create
  #
  #   @move = Move.new
  #   @move.id = params[:id]
  #   if params[:top]
  #     @move.top = params[:top]
  #   end
  #   if params[:left]
  #     @move.left = params[:left]
  #   end
  #   @move.user_id = params[:user_id]
  #
  #   if @move.save
  #     ActionCable.server.broadcast 'MovesChannel', {
  #       id: @move.id,
  #       left: @move.left,
  #       top: @move.top,
  #       user_id: @move.user_id,
  #       type: params['type']
  #     }
  #     render json: {
  #       id: @move.id
  #     }
  #   else
  #
  #     render json: {
  #       id: @move.id
  #     }
  #   end
  #
  # end

  def create
    ActionCable.server.broadcast 'MovesChannel', {
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
