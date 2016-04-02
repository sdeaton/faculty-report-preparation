class Evaluation < ActiveRecord::Base
  belongs_to :instructor

  def self.create_if_needed_and_update(key_attrs, other_attrs)
    evaluation = where(key_attrs).first_or_initialize
    is_new_record = evaluation.new_record?
    evaluation.save

    evaluation.update(other_attrs)

    is_new_record
  end

  def self.default_sorted_groups
    all.group_by do |eval|
      eval.term.to_s + eval.subject.to_s + eval.course.to_s + eval.instructor.id.to_s + eval.section.to_s[0]
    end.sort { |group1, group2| group1.first <=> group2.first }.map(&:last)
  end
end
