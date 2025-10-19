class SectionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sections = current_user.sections
    @section = Section.new # フォーム用（newではなくindexでフォーム表示するため）
  end

  def create
    @section = current_user.sections.build(section_params.merge(started_at: Time.current))

    if @section.save
      # アクション開始画面へ遷移
      redirect_to new_section_action_path(@section), notice: "セクションを開始しました！"
    else
      redirect_to sections_path, alert: "セクション開始に失敗しました。"
    end
  end

  def end_section
    @section = Section.find(params[:id])
    if @section.update(ended_at: Time.current)
      redirect_to root_path, notice: "セクションを終了しました。"
    else
      redirect_to new_section_action_path(@section), alert: "セクション終了に失敗しました。"
    end
  end

  def chart
    @section = current_user.sections.find_by(id: params[:id])
    if @section.nil?
      redirect_to feedbacks_path, alert: "セクションが見つかりませんでした。"
      return
    end

    # 終了しているアクションのみ取得
    @actions = @section.actions.where.not(ended_at: nil)

    # 各アクションの duration_minutes を計算
    @actions = @actions.map do |action|
      duration_minutes = ((action.ended_at - action.started_at) / 60).round
      action.define_singleton_method(:duration_minutes) { duration_minutes }
      action
    end

    # カテゴリ別の合計時間
    @category_data = @actions.group_by(&:category).transform_values do |acts|
      acts.sum { |a| a.duration_minutes }
    end
  end

  private

  def section_params
    params.require(:section).permit(:name)
  end
end
