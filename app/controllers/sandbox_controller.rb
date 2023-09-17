class SandboxController < ApplicationController

  def index


  @all = Sandbox.all
  end

end
