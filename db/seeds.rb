# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

Role.create!(name: 'Faculty', code: 'FAC')
Role.create!(name: 'Student', code: 'STU')
Role.create!(name: 'Head Of Department', code: 'HOD')

Department.create!(name: 'Computer Science & Engineering', code: 'CSE')
Department.create!(name: 'Civil Engineering', code: 'CIVIL')
Department.create!(name: 'Electrical & Communication Engineering', code: 'ECE')
Department.create!(name: 'Electrical & Electronics Engineering', code: 'EEE')
Department.create!(name: 'Mechanical Engineering', code: 'MECH')

Course.create!(name: 'Batcher Of Technology', code: 'BTECH')
Course.create!(name: 'Master Of Technology', code: 'MTECH')

Regulation.create!(name: 'Regulation 19', code: 'R19')
Regulation.create!(name: 'Regulation 20', code: 'R20')

Batch.create!(name: '2019-2023')
Batch.create!(name: '2020-2024')

Semester.create!(name: 'I')
Semester.create!(name: 'II')
Semester.create!(name: 'III')
Semester.create!(name: 'IV')
Semester.create!(name: 'V')
Semester.create!(name: 'VI')
Semester.create!(name: 'VII')
Semester.create!(name: 'VIII')