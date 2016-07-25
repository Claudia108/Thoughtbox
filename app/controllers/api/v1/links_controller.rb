class Api::V1::LinksController < Api::V1::ApiController
  before_action :require_user

  def index
    if current_user.nil?
      render file: '/public/404'
    else
      render json: current_user.links.all
    end
  end

  def create
    render json: Link.create(link_params)
  end

   def update
    if link_params[:read]
      render json: Link.update(params[:id], read: link_params[:read].to_i)
    else
      render json: Link.update(params[:id], link_params)
    end
  end

  def destroy
    Link.delete(params[:id])
    render json: params[:id]
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :read)
  end
end
