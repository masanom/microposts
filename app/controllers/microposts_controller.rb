class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create]
    def create
      @microposts = current_user.microposts.build(micropost_params)
      if @midropost.save
          flash[:success] = "Micropost created!"
          redirect_to root_path
      else
        render static_page/home  
      end
    end
    
    privete
    
    def micropost_params
        params.require(:micropost).permit(:content)
    end

end
