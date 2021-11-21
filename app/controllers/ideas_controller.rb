class IdeasController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show, :create]
  before_action :unauthorized_user, only: [:index, :show, :create]
  before_action :user_set, only: [:index, :show, :create]

  def index
    @ideas = @user.ideas
    @data = @ideas.map { |x| x.to_json }
    render json: { status: 200, data: @data }
  end

  def create
    @idea = Idea.new(idea_params)
    if @idea.valid?
      @idea.save
      render json: { status: 201, message: '保存に成功しました'}
    else
      render json: { status: 422, message: 'バリデーションエラー' }
    end
  end

  private
  def idea_params
    params.permit(:title, :memo).merge(user_id: current_user.id)
  end

  def unauthorized_user
    return render json: { status: 404, message: 'ユーザーが違います' } unless params[:user_id] == current_user.id.to_s
  end

  def user_set
    @user = User.find_by(params[:user_id])
  end

end
