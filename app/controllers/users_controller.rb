class UsersController < ApplicationController
	before_filter :authenticate_user!, only: [:index]
	before_filter do
		redirect_to "/" unless current_user && current_user.admin?
	end

	def index
		render template: "user/admin"
	end

	def userlist
	  @users = User.paginate(:page=>params[:page],:per_page=>10).recent
	end

	def edit
	end

	def update
    respond_to do |format|
      if @user.update(params[:role])
        format.html { redirect_to @user, notice: 'User updated successfully.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
