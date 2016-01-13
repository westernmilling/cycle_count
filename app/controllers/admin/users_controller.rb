module Admin
  class UsersController < ApplicationController
    respond_to :html

    def index
      @users = User.all.page(params[:page])
    end

    def new
      render_new
    end

    def create
      render_new and return unless entry.valid?

      handle_service_result(user_create,
                            -> { redirect_to admin_users_path },
                            -> { render_new })
    end

    def edit
      render_edit
    end

    def update
      render_edit and return unless entry.valid?

      handle_service_result(user_update,
                            -> { redirect_to admin_users_path },
                            -> { render_edit })
    end

    private

    def render_new
      render :new, locals: { entry: entry }
    end

    def render_edit
      render :edit, locals: { entry: entry, user: user }
    end

    def entry
      return @entry ||= UserEntry.new(user_params) \
        if %{create new}.include?(params[:action])
      @entry ||= find_user
    end

    def user_create
      CreateUser.call(user_params)
    end

    def user_update
      UpdateUser.call(user_params.merge(id: user.id))
    end

    def user_params
      return {} if params[:entry].nil?

      params
        .require(:entry)
        .permit(:email, :name, :is_active)
    end

    def user
      @user ||= params[:id] ? find_user : build_user
    end

    def build_user
      User.new(user_params)
    end

    def find_user
      User.find(params[:id])
    end
  end
end
