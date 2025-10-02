class Action < ApplicationRecord
  belongs_to :section

  enum category: { housework: "家事", work: "仕事", study: "勉強", play: "娯楽", rest: "休憩", other: "その他" }
end
