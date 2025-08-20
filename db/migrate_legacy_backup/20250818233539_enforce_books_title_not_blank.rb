class EnforceBooksTitleNotBlank < ActiveRecord::Migration[7.1]
  def up
    # If any bad rows exist, give them a placeholder so constraints can be added
    execute "UPDATE books SET title = 'Untitled' WHERE title IS NULL OR btrim(title) = ''"

    change_column_null :books, :title, false
    add_check_constraint :books, "char_length(btrim(title)) > 0", name: "books_title_not_blank"
  end

  def down
    remove_check_constraint :books, name: "books_title_not_blank"
    change_column_null :books, :title, true
  end
end

