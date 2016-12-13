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

  	#make admin user
  	def makeadmin
  		@user=User.find(params[:id])
  		if @user.role != 'admin'
  			@user.update_attributes(:role => 'admin')
  			flash[:notice] = "#{@user.name} is marked as Admin now"  			
  		end
  		if @user.role == "admin" || @user.role == "Admin"
  			flash[:notice] = "#{@user.name} is already Admin"
  		else
  			flash[:notice] = "Something went wrong"
  		end
      redirect_to "/userlist"
  	end

  	#make normal user
  	def makeparticipant
  		@user=User.find(params[:id])
  		if @user.role != 'participant'
  			@user.update_attributes(:role => 'participant')
  			flash[:notice] = "#{@user.name} is marked as Normal user now"
  		end
  		if @user.role == "participant" || @user.role == "participant"
  			flash[:notice] = "Role of #{@user.name} is already Participant"
  		else
  			flash[:notice] = "Something went wrong"
  		end
      redirect_to "/userlist"
  	end
end
