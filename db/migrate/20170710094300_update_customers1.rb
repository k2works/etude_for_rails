class UpdateCustomers1 < ActiveRecord::Migration[5.1]
  def up
    if Rails.env != 'test'
      execute(%q{
      UPDATE baukis_customers SET birth_year = EXTRACT(YEAR FROM birthday),
       birth_month = EXTRACT(MONTH FROM birthday),
       birth_mday = EXTRACT(DAY FROM birthday)
       WHERE birthday IS NOT NULL
    })
    end
  end

  def down
    if Rails.env != 'test'
      execute(%q{
      UPDATE baukis_customers SET birth_year = NULL,
                           birth_month = NULL,
                           birth_mday = NULL
    })
    end
  end
end
