class UserController < ApplicationController
    def index
        @users = User.all
    end

    def new
        @user = User.new
    end

    def show
        
    end
    
    def edit
    end

    def update
        if @user.update(user_params)
            flash[:success] = "Your account Information was successfully updated"
            redirect_to @user
        else
            render 'edit'
        end
        end

    def create
        @user = User.new(user_params)
            if @user.save
                session[:user_id] = @user.id
                flash[:success] = "Welcome to Alpha Blog #{@user.username}. You are successfully Signed up"
                redirect_to root_path
            else
                render :new
            end
        end

    def destroy
        @user.destroy
        session[:user_id] = nil if @user = current_user
        flash[:success] = "Account and all associated articles successfully deleted"
        redirect_to root_path
    end

        private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:username, :password)
    end

    def require_same_user
        if current_user != @user && !current_user.admin
        flash[:error] = "You can only Edit or Delete your own account"
        redirect_to @user
        end
    end
end
