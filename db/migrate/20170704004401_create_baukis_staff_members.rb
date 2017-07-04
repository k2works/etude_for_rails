class CreateBaukisStaffMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :baukis_staff_members do |t|

      t.timestamps
    end
  end
end
