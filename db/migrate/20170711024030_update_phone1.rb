class UpdatePhone1 < ActiveRecord::Migration[5.1]
  def up
    if Rails.env != 'test'
      execute(%q{
      UPDATE baukis_phones SET last_four_digits = SUBSTR(number_for_index, LENGTH(number_for_index) - 3)
       WHERE number_for_index IS NOT NULL AND LENGTH(number_for_index) >= 4
    })
    end
  end

  def down
    if rails.env != 'test'
      execute(%q{
      UPDATE baukis_phones SET last_four_digits = NULL
    })
    end
  end
end
