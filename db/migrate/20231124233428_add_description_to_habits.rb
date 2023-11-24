class AddDescriptionToHabits < ActiveRecord::Migration[7.0]
  def change
    add_column :habits, :description, :text
  end
end
