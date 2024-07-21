class IntroductionColumnDefaultToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :introduction, from: nil, to: "よろしくお願いします!"
  end
end
