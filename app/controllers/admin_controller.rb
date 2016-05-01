class AdminController < ApplicationController

  before_action :authenticate_user!
  before_action :verify_admin

  def verify_admin
    unless can? :manage, :all
      redirect_to root_path
    end
  end

  def index
    @users = User.all
    render layout: "layouts/application"
  end

  def change_to_admin
    User.find(user_id).roles = []
    User.find(user_id).add_role :admin
    flash[:notice] = "#{current_user.email} has been changed to Admin"
    redirect_to admin_index_path
  end

  def change_to_read_write
    if verify_min_admin
      User.find(user_id).roles = []
      User.find(user_id).add_role :readWrite
      flash[:notice] = "#{User.find(user_id).email} has been changed to Read/Write"
    else
      flash[:errors] = "Minimum of 1 administrator required"
    end
    redirect_to admin_index_path
  end

  def change_to_read_only
    if verify_min_admin
      User.find(user_id).roles = []
      User.find(user_id).add_role :readOnly
      flash[:notice] = "#{User.find(user_id).email} has been changed to Read Only"
    else
      flash[:errors] = "Minimum of 1 administrator required"
    end
    redirect_to admin_index_path
  end

  def change_to_guest
    if verify_min_admin
      User.find(user_id).roles = []
      User.find(user_id).add_role :guest
      flash[:notice] = "#{ User.find(user_id).email} has been changed to Guest"
    else
      flash[:errors] = "Minimum of 1 administrator required"
    end
    redirect_to admin_index_path
  end

  def remove_user
    if verify_min_admin
      email = User.find(user_id).email
      User.find(user_id).destroy
      flash[:notice] = "#{email} has been removed"
    else
      flash[:errors] = "Minimum of 1 administrator required"
    end
    redirect_to admin_index_path
  end

  def user_id
    params.require(:admin_id)
  end

  def verify_min_admin
    (!User.find(params.require(:admin_id)).has_role? :admin) || (User.with_role(:admin).length > 1)
  end
end
