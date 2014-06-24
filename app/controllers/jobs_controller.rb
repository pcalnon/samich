class JobsController < ApplicationController
  def show
    @job = Job.find(params[:id])
  end

  def new
  end

end
