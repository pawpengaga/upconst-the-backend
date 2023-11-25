User.create!(email: "admin@admin.com", password: "12345678", name: "admin")
User.create!( email: "jhonatanveliz74@gmail.com", password: "password2023", name: "Jhonatan Veliz" )
User.create!(email: "b4u@mail.jp", password: "12345678", name: "RIYU")

Habit.create(name: "Dejar de procrastinar con los cursos XD", user_id: 1, description: "Hola")

Habit.create(name: "Hacer ejercicio", user_id: 3, description: "Hola de nuevo")
Habit.create(name: "Dibujar todos los días", user_id: 3, description: "Nose")

10.times do |u|
  Tracker.create(user_id: 1, habit_id: 1)
end
