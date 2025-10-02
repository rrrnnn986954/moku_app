class SectionsController < ApplicationController
  before_action :authenticate_user!
  def index
    @sections = current_user.sections
  end

  def create
    @section = current_user.sections.build(started_at: Time.current)

    if @section.save
      # アクション開始画面へ遷移
      redirect_to new_section_action_path(@section), notice: "セクションを開始しました！"
    else
      redirect_to sections_path, alert: "セクション開始に失敗しました。"
    end
  end
end
