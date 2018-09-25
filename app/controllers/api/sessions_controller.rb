# class Api::SessionsController < ApplicationController
#
#   def create
#
#
#     @user = User.find_by(username: params['username'])
#
#
#     payload = { username: params['username'] }
#     secret_key = secret_key()
#
#     # IMPORTANT: SET NIL AS PASSWORD PARAMETER
#     token = JWT.encode payload, secret_key, 'HS256'
#
#
#     if @user && @user.authenticate(params[:password])
#       render json: {
#         username: @user.username,
#         id: @user.id,
#         token: token
#       }
#     else
#       render json: {
#         errors: "Those credentials don't match anything we have in our database"
#       }, status: :unauthorized
#     end
#   end
#
#   def destroy
#     session.delete(:user_id)
#     redirect_to login_path
#   end
#
#
#
# end

class Api::SessionsController < ApplicationController

  def create


    @user = User.find_by(username: params['username'])


    # payload = { username: params['username'], id: @user.id }
    secret_key = secret_key()

    # IMPORTANT: SET NIL AS PASSWORD PARAMETER
    # token = JWT.encode payload, secret_key, 'HS256'

    # puts token
    # puts 'whats up'

    if @user && @user.authenticate(params[:password])
      # payload = { username: params['username'], id: @user.id }
      render json: {
        username: @user.username,
        id: @user.id,
        token: get_token(payload(@user.username, @user.id) )
      }
    else
      render json: {
        errors: "Those credentials don't match anything we have in our database"
      }, status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path
  end



end
