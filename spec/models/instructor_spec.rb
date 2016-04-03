require 'rails_helper'

RSpec.describe Instructor, type: :model do

  let(:instructor) { Instructor.create(name: 'Brent Walther') }

  describe "\#courses_taught" do
    it "sums the enrollment of different sections of the same course" do
      Evaluation.create(term: '2015C', subject: 'CSCE', course: '110',
        section: '501', instructor: instructor, enrollment: 10,
        item1_mean: 3.9, item2_mean: 3.9, item3_mean: 3.9, item4_mean: 3.9,
        item5_mean: 3.9, item6_mean: 3.9, item7_mean: 3.9, item8_mean: 3.9)
      Evaluation.create(term: '2015C', subject: 'CSCE', course: '110',
        section: '502', instructor: instructor, enrollment: 10,
        item1_mean: 3.9, item2_mean: 3.9, item3_mean: 3.9, item4_mean: 3.9,
        item5_mean: 3.9, item6_mean: 3.9, item7_mean: 3.9, item8_mean: 3.9)

      expect(instructor.courses_taught.first.total_enrollment).to eq(20)
    end

    it "computes the average evaluation score for each course taught" do
      Evaluation.create(term: '2015C', subject: 'CSCE', course: '110',
        section: '501', instructor: instructor, enrollment: 10,
        item1_mean: 3.9, item2_mean: 3.9, item3_mean: 3.9, item4_mean: 3.9,
        item5_mean: 3.9, item6_mean: 3.9, item7_mean: 3.9, item8_mean: 3.9)
      Evaluation.create(term: '2015C', subject: 'CSCE', course: '110',
        section: '502', instructor: instructor, enrollment: 10,
        item1_mean: 4.1, item2_mean: 4.1, item3_mean: 4.1, item4_mean: 4.1,
        item5_mean: 4.1, item6_mean: 4.1, item7_mean: 4.1, item8_mean: 4.1)

      expect(instructor.courses_taught.first.mean_eval_score).to eq(4.0)
    end
  end
end
