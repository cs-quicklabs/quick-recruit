class MakeRecycledateNonNullable < ActiveRecord::Migration[8.0]
  def change
    change_column_null :candidates, :next_recycle_on, false, 6.months.from_now
  end
end
