User.destroy_all

# 20 students
20.times.each do |i|
  student = User.create
  student.create_email_credential(email: 'student' + i.to_s + '@example.com', password: '123456', password_confirmation: '123456')
end

# 5 teachers
5.times.each do |i|
  teacher = User.create(kind: :teacher)
  teacher.create_email_credential(email: 'teacher' + i.to_s + '@example.com', password: '123456', password_confirmation: '123456')
end
