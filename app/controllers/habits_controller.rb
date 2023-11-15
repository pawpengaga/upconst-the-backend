class HabitsController < ApplicationController
  def index
    @habits = Habit.all()
    render json: @habits, status: 200
  end

  def show
    @habit = Habit.find(params[:id])
    if @habit
      render json: @habit, status: 200
    else
      render json: {
        error: "NO EXISTE BOBO QUE BOBO XD"
      }
    end
  end

  def create
    @habit = Habit.new(habit_params())

    if @habit.save
      render json: @habit, status: 200
    else
      render json: {error: "QUE BOBO XD"}
    end
  end

  def update
    @habit = Habit.find(params[:id])

    if @habit
      @habit.update(habit_params)
      render json: "Editado con exito! ELIMINAR LUEGO"
    else
      render json: {error: "QUE BOBOBOBO XD"}
    end
  end

  def destroy
    @habit = Habit.find(params[:id])

    if @habit
      @habit.destroy()
      render json: "NOOO LO MATASTEEE, AHORA QUE NO EXISTE"
    else
      render json: {error: "QUE BOBO SIGUE CON SUS BOBADAS QUE BOBO"}
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :user_id)
  end

end
