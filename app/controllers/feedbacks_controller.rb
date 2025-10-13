class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def index
    @sections = current_user.sections.order(created_at: :desc)
  end
end
