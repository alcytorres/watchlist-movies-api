class RenameNameToTitleInMovies < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :name, :title
  end
end
