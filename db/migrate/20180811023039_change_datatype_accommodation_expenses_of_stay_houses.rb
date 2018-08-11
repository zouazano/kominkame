class ChangeDatatypeAccommodationExpensesOfStayHouses < ActiveRecord::Migration[5.2]
  def change
  	change_column :stay_houses, :accommodation_expenses, :float
  end
end
