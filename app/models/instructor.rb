class Instructor < ActiveRecord::Base
  has_many :evaluations

  def courses_taught
    eval_columns = (1..8).map { |num| "AVG(item#{num}_mean)" }.join("+")
    grouped_courses.select([
      :term,
      :subject,
      :course,
      "SUM(enrollment) as total_enrollment",
      "((#{eval_columns}) / 8.0) as mean_eval_score"
    ])
  end

  def grouped_courses
    evaluations.group([:term, :subject, :course])
  end
end
