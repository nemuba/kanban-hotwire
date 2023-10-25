# frozen_string_literal: true

class CreateWorkspaces < ActiveRecord::Migration[7.1]
  def change
    create_table :workspaces do |t|
      t.string :title, null: false

      t.timestamps
    end

    add_index :workspaces, :title, using: :gin, opclass: { title: :gin_trgm_ops },
                                   name: 'index_workspaces_on_title_trgm'
  end
end
