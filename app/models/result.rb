class Result < ApplicationRecord
    belongs_to :user
    belongs_to :semester

    before_save :upcase_fields

    def upcase_fields
        self.subject_title.upcase!
        self.result_type.upcase!
        self.result.upcase!
    end

    def self.import(file, current_user_id)
        begin
            records = CSV.parse(File.read(file), headers: true)
            records.each do |student_record|
                arr_of_stu_record = student_record.to_a
                puts "Uploading result of : #{arr_of_stu_record[0]}"
                (3..arr_of_stu_record.length-1).step(6).each do |index| 
                    Result.create!(
                    subject_title: arr_of_stu_record[index].first.upcase,
                    internal_marks: arr_of_stu_record[index+1].last,
                    external_marks: arr_of_stu_record[index+2].last,
                    total_marks: arr_of_stu_record[index+3].last,
                    result: arr_of_stu_record[index].last.upcase == "P" ? "PASS" : "FAIL",
                    credits: arr_of_stu_record[index+4].last,
                    grade: arr_of_stu_record[index+5].last,
                    result_type: "REGULAR",
                    user_id: User.find_by(rollno: arr_of_stu_record[0].last.upcase).id,
                    semester_id: Semester.find_by(id: arr_of_stu_record[2].last.upcase).id,
                    last_updated_user_id: current_user_id
                    )
                end
                puts "#{arr_of_stu_record[0]} -> #{arr_of_stu_record[1]} result Uploaded successfully."
            end
            1
        rescue => exception
            puts "\n\n\n*********************#{exception} occured in result creation*********************\n\n\n"
            0
        end
    end
end
