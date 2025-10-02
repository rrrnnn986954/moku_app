module ActionsHelper
  def japanese_category(category)
    case category
    when "housework" then "家事"
    when "work"      then "仕事"
    when "study"     then "勉強"
    when "hobby"     then "娯楽"
    when "rest"      then "休憩"
    when "other"     then "その他"
    else "未設定"
    end
  end
end
