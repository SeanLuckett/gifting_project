class CreateRecommendationsToBuy < ActiveRecord::Migration
  def change
    create_table :recommendation_to_buys do |t|
      t.integer :recipient_id
      t.integer :event_id
      t.string :gift_name
      t.string :gift_url
      t.boolean :bought
      t.datetime :buy_date

      t.timestamps
    end
  end
end
