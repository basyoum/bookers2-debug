class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update]

  def index
    @book = Book.new
    @groups = Group.all
    #@group = Group.find(params[:id])
  end

  def show
    @book = Book.new
    @group = Group.find(params[:id])
  end

  #グループに参加
  def join
    @users = User.all
    @group = Group.find(params[:group_id])
    # @group.usersにcurrent_userを追加するという意味
    @group.users << current_user
    redirect_to groups_path
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    # @group.usersにcurrent_userを追加するという意味
    # グループ作成者をメンバーに入れる
    @group.users << current_user
    if @group.save
      redirect_to groups_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      redirect_to groups_path
    else
      render 'edit'
    end
  end

  #グループから退会
  def destroy
    @group = Group.find(params[:id])
    # current_userは@group.usersから消されるという意味
    @group.users.delete(current_user)
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end

end
