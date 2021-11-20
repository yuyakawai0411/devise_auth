class IdeasController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  # before_action :unauthorized_user, only: [:create]

  def index
    @ideas = Idea.all
    @data = @idea.map { |x| x.to_json }
    render json: { status: 200, data: @data }
  end

  def show
    @idea = find(paranms[:id])
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.valid?
      @idea.save
      render json: { status: 201, message: '保存い成功しました'}
    else
      render json: { status: 422, message: 'バリデーションエラー' }
    end
  end

  private
  def idea_params
    params.permit(:title, :memo).merge(user_id: current_user.id)
  end

  def unauthorized_user
    unless @idea.user.id == current_user.id
      redirect_to root_path
    end
  end
end
