class ApplicationController < ActionController::API

  def secret_key
    # 'secret key'
    ENV['SECRET_KEY']
  end

  def authorization_token
    request.headers["Authorization"]
  end

  def decoded_token
    JWT.decode authorization_token(), secret_key(), true, { algorithm: 'HS256' }

    begin
      return JWT.decode authorization_token(), secret_key(), true, { algorithm: 'HS256' }
    rescue  JWT::VerificationError, JWT::DecodeError
      return nil
    end

  end

  def valid_token?
    !!try_decode_token
  end

  def requires_login
    if !valid_token?
      render json: {
        message: 'INFO ENTERED IS WRONG!!!'
      }, status: :unauthorized
    end
  end

  def is_admin
    decoded_token[0]["id"] < 100
  end

  # def authenticate(data)
  #   begin
  #     if (decoded_token())
  #       render json: data
  #     end
  #
  #   rescue JWT::DecodeError
  #     render json: {
  #       message: 'INFO ENTERED IS WRONG!!!'
  #     }, status: :unauthorized
  #   end
  # end


  # authenticate
  def try_decode_token

    begin
      decoded = JWT.decode(authorization_token(), secret_key(), true, { algorithm: 'HS256' })
    rescue JWT::VerificationError, JWT::DecodeError
      return nil
    end

    decoded
  end


  def authorized(user)
    current_user_id == user.id
  end


  def payload (name, id)
    { name: name, id: id}
  end



  def get_token(payload)
    JWT.encode payload, secret_key(), 'HS256'
  end





end
