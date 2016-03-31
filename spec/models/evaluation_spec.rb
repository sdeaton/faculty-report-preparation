require 'rails_helper'

RSpec.describe Evaluation, type: :model do

  let(:instructor) { Instructor.create(name: 'Brent Walther') }

  it "should belong to an instructor" do
    eval = Evaluation.create(term: '2015C', subject: 'CSCE', course: '110',
      section: '501', instructor: instructor, enrollment: 10)

    expect(eval.instructor).to eq(instructor)
  end
end
