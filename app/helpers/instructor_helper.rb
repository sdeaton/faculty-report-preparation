module InstructorHelper
  def course_name_for(course_section_group)
    "#{course_section_group.first.subject} #{course_section_group.first.course}" +
        (course_section_group.first.is_honors_section? ? "H" : "")
  end
end
