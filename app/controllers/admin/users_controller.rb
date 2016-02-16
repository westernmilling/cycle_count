module Admin
  class UsersController < ApplicationController
    before_action -> { authorize :user }
    respond_to :html

    def index
      render_index
    end

    def show
      render_show
    end

    def new
      render_new
    end

    def create
      if user.save
        redirect_to admin_user_path(user),
                    notice: t('.success')
      else
        render_new
      end
    end

    def edit
      render_edit
    end

    def update
      if user.update_attributes(user_params)
        redirect_to admin_user_path(user),
                    notice: t('.success')
      else
        render_edit
      end
    end

    private

    def render_index
      render :index, locals: { users: users }
    end

    def render_show
      render :show, locals: { user: user }
    end

    def render_new
      render :new, locals: { user: user }
    end

    def render_edit
      render :edit, locals: { user: user }
    end

    def user_params
      return {} if params[:user].nil?

      params
        .require(:user)
        .permit(:email, :name, :is_active, :role_name)
    end

    def user
      @user ||= params[:id] ? find_user : build_user
    end

    def users
      @users ||= User.all.page(params[:page])
    end

    def build_user
      User.new(user_params)
    end

    def find_user
      User.find(params[:id])
    end
  end
end
