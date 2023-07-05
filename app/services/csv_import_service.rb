class CsvImportService
  require 'csv'

  def call(file)
    opened_file = File.open(file)
    # options = { headers: true, col_sep: ';' }
    options = { headers: true }
    CSV.foreach(opened_file, **options) do |row|
      user_hash = {}
      user_hash[:email] = row['Email Address'] || ''
      user_hash[:username] = user_hash[:email].split('@').first
      user_hash[:name] = row['First Name'] || ''
      user_hash[:surname] = row['Last Name'] || ''
      user_hash[:preferences] = row['Favorite Food'] || ''
      user_hash[:phone] = row['Mobile phone number']

      User.find_or_create_by!(user_hash)

    end
  end
end
