class SessionsController < ApplicationController

  def new
  end

  def create
    # If the user is authenticated
    if user = User.authenticate_with_credentials(params[:email], params[:password])
      # Save the user id inside the browser cookie and redirect to home
      session[:user_id] = user.id
      redirect_to '/'
    else
    # If user's login doesn't work, send them back to the login form.
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

end
