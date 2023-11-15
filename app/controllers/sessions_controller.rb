class SessionsController < ApplicationController

    
    
    def login
        if request.post?

            user = User.find_by(username: params[:username])

            if user && user.authenticate(params[:password])
                token = JWT.encode({user_id: user.id}, 'your_secret_key', 'HS256')

                cookies.signed[:user_token] = {value: token, httponly: true, expires: 1.hour.from_now}

                render json: {user_id: user.id}
            else
                render status: 400, json: {error: 'Invalid username or password'}
            end
        else
            render :login
        end

    end
end
