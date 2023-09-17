class SandboxController < ApplicationController

  def index
    @all = Sandbox.all
  end

  def show
    @sandbox = Sandbox.find(params[:id])
  end

end
