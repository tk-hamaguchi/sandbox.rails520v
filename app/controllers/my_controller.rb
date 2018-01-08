class MyController < ApplicationController
  before_action :authenticate_user!

  def top; end

  def edit; end

  def update
    if current_user.update(user_params)
      flash[:notice] = I18n.t('applicationcontroller.my.update.flash.updated')
      return redirect_to edit_my_path
    end
    render :edit
  end

  private

  def user_params
    up = params.require(:user).permit(:name, :password, :password_confirmation)
    up.extract!(:password, :password_confirmation) if up[:password].blank?
    up
  end
end
