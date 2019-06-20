module ExercisesHelper
  def index_content
    if @exercises.empty? 
      default = 'No Exercises Created'
      content_tag(:h1, class: 'text-center', style: 'margin:15px') do
        concat user_id?
        concat default
      end
    else
      render partial: 'list_exercises'
    end
  end

  def exercise_owner(exercise)
    if exercise.user == current_user then render partial: 'edit_delete', locals: {exercise: exercise} end
  end

  def user_id?
    if current_user != nil then render partial: 'create_exercise' end
  end

  def counter_pluralize
    if @exercise.count == 1
      default = "Viewed #{@exercise.count} Time"
      content_tag(:p, default, id: 'visited')
    else
      default = "Viewed #{@exercise.count} Times"
      content_tag(:p, default, id: 'visited')
    end
  end
end