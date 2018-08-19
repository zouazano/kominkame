# This migration comes from ebisu (originally 20180128022809)
class AddColumnToEbisuFigure < ActiveRecord::Migration[5.1]
  def change
    add_column :ebisu_figures, :source, :string
    add_column :ebisu_figures, :source_url, :string
  end
end
