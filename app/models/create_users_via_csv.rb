require 'csv'

class CreateUsersViaCsv
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      CSV.parse(csv_file, headers: true) do |row|
        fields = row.to_hash
        User.create!(fields)
        puts "User #{fields["name"]} #{fields["rollno"]} #{fields["email"]} created successfully!!!!"
        WelcomeMailer.with(name: fields["name"], email: fields["email"]).welcome_user.deliver_later
      end
    end
  end
end