class FeedbacksController < ApplicationController
  before_action :authenticate_user!

  def index
    # 終了しているセクションのみ取得
    @sections = current_user.sections
                            .where.not(ended_at: nil)     # ← 終了済みだけ
                            .order(created_at: :desc)     # 新しい順に並べる
  end
end
