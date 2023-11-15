class UsersController < ApplicationController
    def register
        if request.post?
            user_params = params.permit(:username, :password, :password_confirmation, :email, :firstname, :lastname)
            
            if user_params[:password] != user_params[:password_confirmation]
                @error_message = 'password and password confirmation donot match'
                render :register, error_message: @error_message
                return
            end

            user_params[:password] = BCrypt::Password.create(user_params[:password])

            user = User.new(user_params)

            if user.save
                params[:username] = params[:password] = params[:password_confirmation] = params[:email] = params[:firstname] = params[:lastname] = nil
                @successs_message = 'User registered successfully'
                render :register, success_message: @success_message 
            else
                @error_message = user.errors.full_messages.join(', ')
                render :register, error_message: @error_message
            end
        else
            render :register
        end

    end
end
