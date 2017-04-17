class ChangeDefaultToArrAndDepTime < ActiveRecord::Migration[5.0]
  def up
    change_column_default :hotel_bookings, :arrival_time, "2:00pm"
    change_column_default :hotel_bookings, :departure_time, "10:00am"
  end

  def down
    change_column_default :hotel_bookings, :arrival_time, nil
    change_column_default :hotel_bookings, :departure_time, nil
  end
end
