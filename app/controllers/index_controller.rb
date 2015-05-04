class IndexController < ApplicationController
  skip_before_filter :authenticate_user_from_token!
  skip_before_filter :authenticate_user!

  def index
  end
end
