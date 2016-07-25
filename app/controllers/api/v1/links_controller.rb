class Api::V1::LinksController < Api::V1::ApiController

  def index
      render json: Link.where(user_id: current_user.id)
    end
  end

  def create
    if current_user 
      render json: Link.create(link_params)
    else
      redirect_to root_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
