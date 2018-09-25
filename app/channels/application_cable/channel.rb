module ApplicationCable
  class Channel < ActionCable::Channel::Base
    def current_user
      @current_user ||= ServiceClass.new(request_data, user_data)
    end
  end
end

class ServiceClass

  def initialize (session, current_user)
    @session = session
    @user = current_user
  end



end
