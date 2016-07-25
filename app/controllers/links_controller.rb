class LinksController < ApplicationController

  def index
   if current_user
      @links = current_user.links
    else
      redirect_to login_path
    end
  end

  private

   def link_params
      params.require(:link).permit(:url, :title)
    end

end
