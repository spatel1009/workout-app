class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @exercise = current_user.exercises.new
  end

  def create
    @exercise = current_user.exercises.new(exercise_params)

    if @exercise.save
      flash[:success] = 'Exercise has been created'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      render 'new'
    end
  end

  def show; end

  def edit; end

  def update
    if @exercise.update!(exercise_params)
      flash[:success] = 'Exercise has been updated'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      render 'edit'
    end
  end

  
  private
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:user_id, :duration_in_min, :workout, :workout_date)
  end
end