Subject.destroy_all

10.times.each do |i|
  Subject.create(title: FFaker::Education.major)
end