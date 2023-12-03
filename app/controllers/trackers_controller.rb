class TrackersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_habit
  #before_action :set_user
  #before_action :set_habit, only: %i[ show edit update destroy ]

  # def set_user
  #   @user = User.find(params[:user_id])
  # end
  # def set_habit
  #   @habit = current_user.habits.find(params[:id])
  # end


  def index
    @habit = Habit.find(params[:habit_id])
    @trackers = @habit.trackers
    render json: @trackers, status: 200
  end

  def show
    @tracker = @habit.trackers.find(params[:id])

    if @tracker
      render json: @tracker, status: 200
    else
      render json: {
        error: "NO EXISTE XDDDD"
      },status: :forbidden
    end
    rescue ActiveRecord::RecordNotFound
      render json: { error: "No ha hecho nada que bobo XDD" }, status: :not_found
  end

  def create
    @tracker = current_user.trackers.new(tracker_params.merge(habit: @habit))

    if @tracker.save
      render json: @tracker, status: :created
    else
      render json: { error: "No se pudo crear el tracker", errors: @tracker.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @tracker = current_user.trackers.find(params[:id])
    @habit = @tracker.habit

    if @tracker.user == current_user
      @tracker.update(tracker_params)
      render json: "Editado con exito! ELIMINAR LUEGO", status: :ok
    else
      render json: {error: "QUE BOBOBOBO XD"}, status: :unprocessable_entity
    end
  end

  def destroy
    @tracker = current_user.trackers.find(params[:id])
    @habit = @tracker.habit

    if @tracker.user == current_user
      @tracker.destroy()
      render json: "Nooo se fueeeee", status: :ok
    else
      render json: {error: "XD"}, status: :unprocessable_entity
    end
  end

  private

  def set_habit
    @habit = current_user.habits.find(params[:habit_id])
  end

  def tracker_params
    params.require(:tracker).permit(:notes, :user_id, :habit_id)
  end
end
