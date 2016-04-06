class Instructor < ActiveRecord::Base
  has_many :evaluations

  validates :name, presence: true, uniqueness: true

  def course_section_groups
    evaluations.default_sorted_groups
  end

  def self.select_menu_options
    order(:name).pluck(:name, :id).push([ "New instructor...", 0 ])
  end
end
