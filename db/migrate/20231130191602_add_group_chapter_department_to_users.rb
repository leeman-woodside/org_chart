class AddGroupChapterDepartmentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :group_id, :integer
    add_column :users, :chapter_id, :integer
    add_column :users, :department_id, :integer
  end
end
