User.create!(email: "admin@admin.com", password: "12345678", name: "admin")
User.create!( email: "jhonatanveliz74@gmail.com", password: "password2023", name: "Jhonatan Veliz" )

Habit.create(name: "Dejar de procrastinar con los cursos XD", user_id: 1)

10.times do |u|
  Tracker.create(user_id: 1, habit_id: 1)
end
