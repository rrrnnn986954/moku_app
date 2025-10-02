# app/controllers/actions_controller.rb
class ActionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_section

  def new
    # そのセクション内で「未終了」のアクションがあるかチェック
    @action = @section.actions.where(ended_at: nil).last
  end

  def create
    @action = @section.actions.build(started_at: Time.current)

    if @action.save
      redirect_to new_action_path(section_id: @section.id), notice: "アクションを開始しました！"
    else
      redirect_to new_action_path(section_id: @section.id), alert: "開始に失敗しました。"
    end
  end

  def update
    @action = @section.actions.find(params[:id])
    if @action.update(ended_at: Time.current)
      redirect_to new_action_path(section_id: @section.id), notice: "アクションを終了しました！"
    else
      redirect_to new_action_path(section_id: @section.id), alert: "終了に失敗しました。"
    end
  end

  private

  def set_section
    @section = Section.find(params[:section_id])
  end
end
