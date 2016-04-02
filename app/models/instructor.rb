class Instructor < ActiveRecord::Base
  has_many :evaluations

  validates :name, presence: true, uniqueness: true

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

  def self.select_menu_options
    order(:name).pluck(:name, :id).push([ "New instructor...", 0 ])
  end
end
