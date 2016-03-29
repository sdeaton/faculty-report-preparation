class InstructorController < ApplicationController
  def show
    @instructor = Instructor.find(id)
  end

  def export
    # export not implemented yet
    redirect_to instructor_path(id: id)
  end

  private
  def id
    params.require(:id)
  end
end
