class LinksController < ApplicationController
  before_action :require_user

  def index
    binding.pry
    @links = current_user.links.all
  end
end
