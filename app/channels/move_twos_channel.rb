class MoveTwosChannel < ApplicationCable::Channel
  def subscribed
    stream_from "MoveTwosChannel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
