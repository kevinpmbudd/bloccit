class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new( params.permit(:name,:email,:password,:password_confirmation) )

    if @user.save
      flash[:notice] = "Welcome to Bloccit #{@user.name}!"
      create_session(@user)
      redirect_to root_path
    else
      flash.now[:alert] = "There was an error creating your account. Please try again."
      render :new
    end
  end

  def confirm
    @user = User.new( params_for_user )
  end

  private
    def params_for_user
      params.require(:user).permit(:name,:email,:password,:password_confirmation)
    end
    helper_method :params_for_user
end
