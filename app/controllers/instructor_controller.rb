class InstructorController < ApplicationController

  before_action :authenticate_user!

  def index
    # return the instructors in sorted order by last name
    @instructors = Instructor.all.sort { |a, b| a.name.split(" ").last <=> b.name.split(" ").last }
  end

  def show
    @instructor = Instructor.find(id)
    @evaluation_groups = Evaluation.default_sorted_groups
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
