class IdeasController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  before_action :unauthorized_user, only: [:create]

  def index

  end

  def show

  end

  def create

  end

  private
  def idea_params

  end

  def unauthorized_user
    unless @idea.user.id == current_user.id
      redirect_to root_path
    end
  end
end
