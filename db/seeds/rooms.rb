Room.destroy_all

10.times.each do |i|
  Room.create(title: "Room #{i}")
end