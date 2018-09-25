class UsersChannel < ApplicationCable::Channel
  def subscribed

    # @game = Game.find_by(params[:game])
    # stream_for @game
    stream_from 'UsersChannel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
