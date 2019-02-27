class BasicsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_left_bar

  def index
    @basic = current_user.basic
  end

  def update
    @basic = current_user.basic
    @basic.update_attributes(basic_params)
    flash[:success] = "更新成功"
    redirect_to basics_path
  end
 
  private
    def basic_params
      params.require(:basic).permit(:name, :logo, :keywords, :is_name, :is_logo)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end 
end
