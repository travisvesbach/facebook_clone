class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.belongs_to :user
      t.belongs_to :from
      t.string :content
      t.string :topic
      t.boolean :read, :default => false

      t.timestamps
    end
  end
end
