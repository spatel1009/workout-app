class ExercisesController < ApplicationController
  before_action :set_exercise, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @user = User.find(params[:user_id])
    @exercises = Exercise.all_user_exer(@user)
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

  def show 
    @exercise.increment!(:count)
  end

  def edit; end

  def update
    if @exercise.update_attributes!(exercise_params)
      flash[:success] = 'Exercise has been updated'
      redirect_to user_exercise_path(current_user, @exercise)
    else
      render 'edit'
    end
  end

  def destroy
    if @exercise.destroy
      flash[:alert] = 'Exercise successfully deleted'
      redirect_to user_exercises_path(current_user)
    end
  end

  
  private
  def set_exercise
    @exercise = Exercise.find(params[:id])
  end

  def exercise_params
    params.require(:exercise).permit(:user_id, :duration_in_min, :workout, :workout_date, :count)
  end
end