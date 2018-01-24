module Admin
  class UsersController < ApplicationController
    before_action :authenticate_super_admin!
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @users = User.all
    end

    def show
    end

    def new
      @user = User.new
    end

    def create
      role = Role.find_by(name: "Admin")
      @user = User.new(user_params)
      @user.role = role

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_path(@user), notice: 'Admin was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
          params[:user].delete(:password)
          params[:user].delete(:password_confirmation)
      end
      respond_to do |format|
        if @user.update(user_params)
          format.html { redirect_to admin_users_path(@user), notice: 'Admin was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @user.destroy
      respond_to do |format|
        format.html { redirect_to admin_path, notice: 'Admin was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def authenticate_super_admin!
      redirect_to admin_path notice: 'Access Denied' unless current_user.is_super_admin?
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :gender, :zipcode, :dob, :employer, :email, :password, :password_confirmation, :role_id)
    end

  end
end

