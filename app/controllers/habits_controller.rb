class HabitsController < ApplicationController
  before_action :authenticate_user!

  def index
    @habits = current_user.habits.includes(:trackers)

    habits_with_trackers = @habits.map do |habit|
      {
        habit: habit.as_json(except: [:updated_at]),
        trackers: habit.trackers.as_json(except: [:updated_at, :user_id, :habit_id])
      }
    end

    render json: habits_with_trackers, status: 200
  end

  def show
    @habit = Habit.find(params[:id])

    if @habit.user == current_user
      render json: {
        habit: @habit.as_json(except: [:updated_at]),
        trackers: @habit.trackers.as_json(except: [:updated_at, :user_id, :habit_id])
      }, status: 200
    else
      render json: {
        error: "No puede verlo que bobo XD"
      }, status: :forbidden
    end
  rescue ActiveRecord::RecordNotFound
    render json: { error: "QUE BUSCA BOBO XD" }, status: :not_found
  end

  def create
    @habit = current_user.habits.new(habit_params)

    if @habit.save
      render json: @habit, status: :created
    else
      render json: {error: "QUE BOBO XD"}, status: :unprocessable_entity
    end
  end

  def update
    @habit = current_user.habits.find(params[:id])

    if @habit.user == current_user
      @habit.update(habit_params)
      render json: "Editado con exito! ELIMINAR LUEGO", status: :ok
    else
      render json: {error: "QUE BOBOBOBO XD"}, status: :unprocessable_entity
    end
  end

  def destroy
    @habit = current_user.habits.find(params[:id])

    if @habit.user == current_user
      @habit.destroy()
      render json: "NOOO LO MATASTEEE, AHORA SI QUE NO EXISTE", status: :ok
    else
      render json: {error: "QUE BOBO SIGUE CON SUS BOBADAS QUE BOBO"}, status: :unprocessable_entity
    end
  end

  private

  def habit_params
    params.require(:habit).permit(:name, :user_id, :description)
  end

end
