# This migration comes from ebisu (originally 20171113041704)
class RenameHeaderToHeadline < ActiveRecord::Migration[5.1]
  def change
  	rename_table :ebisu_headers, :ebisu_headlines
  end
end
