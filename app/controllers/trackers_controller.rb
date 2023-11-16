class TrackersController < ApplicationController
  def index
    @trackers = Tracker.all()
    render json: @trackers, status: 200
  end

  def show
    @tracker = Tracker.find(params[:id])
    if @tracker
      render json: @tracker, status: 200
    else
      render json: {error: "NO EXISTE XDDDD"}
    end
  end

  def create
    @tracker = Tracker.new(tracker_params())

    if @tracker.save
      render json: @tracker, status: 200
    else
      render json: {error: "QUE BOBO XD"}
    end
  end

  def update
    @tracker = Tracker.find(params[:id])

    if @tracker
      @tracker.update(tracker_params)
      render json: "Editado con exito! ELIMINAR LUEGO"
    else
      render json: {error: "QUE BOBOBOBO XD"}
    end
  end

  def destroy
    @tracker = Tracker.find(params[:id])

    if @tracker
      @tracker.destroy()
      render json: "Nooo se fueeeee"
    else
      render json: {error: "XD"}
    end
  end

  private

  def tracker_params
    params.require(:tracker).permit(:notes, :user_id, :habit_id)
  end
end
