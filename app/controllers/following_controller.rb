class FollowingController < ApplicationController
  before_filter :login_required

  def index
    @cursor = current_user.following(params[:cursor])
  end
end
