class SectionsController < ApplicationController
  def index
  end

  def create
    @section = Section.new(started_at: Time.current)

    if @section.save
      redirect_to sections_path, notice: "セクションを開始しました！"
    else
      redirect_to sections_path, alert: "セクション開始に失敗しました。"
    end
  end
end
