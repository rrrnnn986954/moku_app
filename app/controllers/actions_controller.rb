# app/controllers/actions_controller.rb
class ActionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_section
  before_action :set_action, only: [:update, :edit, :update_category]

  def new
    # そのセクション内で「未終了」のアクションがあるかチェック
    @action = @section.actions.where(ended_at: nil).last
  end

  def create
    @action = @section.actions.build(started_at: Time.current)

    if @action.save
      redirect_to new_section_action_path(@section), notice: "アクションを開始しました！"
    else
      redirect_to new_section_action_path(@section), alert: "開始に失敗しました。"
    end
  end

  def update
    @action = @section.actions.find(params[:id])
    if @action.update(ended_at: Time.current)
      redirect_to edit_section_action_path(@section, @action), notice: "アクションを終了しました！"
    else
      redirect_to new_action_path(section_id: @section.id), alert: "終了に失敗しました。"
    end
  end

  def edit
    # カテゴリー選択画面
  end

  def update_category
    if @action.update(action_params)
      redirect_to new_section_action_path(@section), notice: "カテゴリーを保存しました！"
    else
      render :edit, alert: "保存に失敗しました。"
    end
  end

  private

  def set_section
    @section = Section.find(params[:section_id])
  end

  def set_action
    @action = @section.actions.find(params[:id])
  end

  def action_params
  params.require(:action_record).permit(:category, :memo)
  end
end
