# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :title, null: false
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end

    add_index :boards, %i[title workspace_id], unique: true, name: 'index_boards_on_title_and_workspace_id'
  end
end
