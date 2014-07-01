class GroupsController < ApplicationController
  before_action :signed_in_user, only: [:create, :edit, :update]
  #before_action :correct_user,   only: [:create, :edit, :update]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = "Congratulations, you have created a new Group! Take another bite of the Samich!"
      redirect_to @group
    else
      render 'new'
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      flash[:success] = "Thank you for updating the group.  Take another bite of the Samich!"
      redirect_to @group
    else
      render 'edit'
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, :primary_investigator, :department, :office, :phone)
    end

    # Before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in to the Samich." unless signed_in?
      end
    end

    #def correct_user
    #  #@user = User.find(params[:id])
    #  @user = current_user
    #  redirect_to(root_url) unless current_user?(@user)
    #end
end
