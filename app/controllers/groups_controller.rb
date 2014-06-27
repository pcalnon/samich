class GroupsController < ApplicationController

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

  private
    def group_params
      params.require(:group).permit(:name, :primary_investigator, :department, :office, :phone)
    end

end
