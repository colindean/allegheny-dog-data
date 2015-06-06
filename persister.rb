require 'sqlite3'

class Persister

  CSV_OPTIONS = {headers: true, return_headers: false, skip_blanks: true}

  def initialize database_file_path
    setup_database database_file_path
  end

  def setup_database database_file_path
    @db = SQLite3::Database.new database_file_path

    @db.execute <<-SQL
      create table if not exists dogs (
        licenseType text not null,
        breed text not null,
        color text not null,
        name text not null,
        ownerZip int not null,
        expYear int not null,
        validDate date not null,
        unique (licenseType, breed, name, ownerZip, expYear, validDate) on conflict ignore);
    SQL
  end

  def save_entry row
    query = 'insert into dogs values(?, ?, ?, ?, ?, ?, ?);'
    @db.execute query, row.fields.delete_if(&:nil?)
  end

  def save_to_database csv_data
    CSV.parse csv_data, CSV_OPTIONS do |row|
      save_entry row
    end
  end

end
