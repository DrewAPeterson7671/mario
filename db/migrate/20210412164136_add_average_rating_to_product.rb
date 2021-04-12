class AddAverageRatingToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column(:products, :average_review, :float, :precision => 1, :scale => 1)
  end
end
