require 'csv'

class CreateUsersViaCsv
  class << self
    def convert_save(model_name, csv_data)
      csv_file = csv_data.read
      CSV.parse(csv_file, headers: true) do |row|
        fields = row.to_hash

        email = fields["Email Address"]
        name = fields["Name"].upcase!
        mobile = fields["Mobile Number"]
        rollno = fields["Roll Number"].upcase!
        department_id = Department.find_by(code: fields["Department"]).id
        course_id = Course.find_by(code: fields["Course"]).id
        if fields["Regulation"]
          regulation_id = Regulation.find_by(code: fields["Regulation"]).id
          role_id = Role.find_by(code: "STU").id
        else
          role_id = Role.find_by(code: "FAC").id
        end
        batch_id = Batch.find_by(name: fields["Batch"]).id
        avatar_url = fields["pass port photo"].split("=").last
        password = (0...8).map { (65 + rand(26)).chr }.join

        User.create!(email: email, name: name, mobile: mobile, rollno: rollno, department_id: department_id, course_id: course_id, regulation_id: regulation_id, batch_id: batch_id, avatar_url: avatar_url, role_id: role_id, password: password, password_confirmation: password)

        puts "User #{name} #{rollno} #{email} #{password} created successfully!!!!"

        WelcomeMailer.with(name: name, email: email, password: password).welcome_user.deliver_later
      end
    end
  end
end