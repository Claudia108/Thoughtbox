class LinksController < ApplicationController
  before_action :require_user

  def index
    @link = Link.new
    @links = current_user.links
  end

  def create
    link = current_user.links.new(link_params)
    if link.save
      flash[:notice] = "#{link.title} Saved!"
      redirect_to links_path
    else
      flash[:notice] = "Data is missing or invalid! Try again"
      redirect_to links_path
    end
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      flash[:notice] = "#{@link.title} Updated!"
      redirect_to links_path
    else
      flash[:notice] = "Data is missing or invalid! Try again"
      redirect_to edit_link_path(@link)
    end
  end

  private

    def link_params
      params.require(:link).permit(:id, :url, :title)
    end

end
