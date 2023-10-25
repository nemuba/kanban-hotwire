# frozen_string_literal: true

class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :title, null: false
      t.text :description
      t.references :board, null: false, foreign_key: true

      t.timestamps
    end

    add_index :cards, %i[title board_id], unique: true, name: 'index_cards_on_title_and_board_id'
  end
end
