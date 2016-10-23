class NullifyRailsProjectsFields < ActiveRecord::Migration[5.0]
  def change
    %i(ruby_version database_adapter database_name database_username
      database_password secret).each do |attr|
      change_column_null :projects, attr, true
    end
  end
end
