class DbUtf8mb4 < ActiveRecord::Migration[5.1]
  def up
    execute("ALTER DATABASE #{current_database} CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;")
  end
end
