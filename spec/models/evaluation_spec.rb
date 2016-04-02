require 'rails_helper'

RSpec.describe Evaluation, type: :model do

  let(:instructor) { Instructor.create(name: 'Brent Walther') }

  it "should belong to an instructor" do
    eval = Evaluation.create(term: '2015C', subject: 'CSCE', course: '110',
      section: '501', instructor: instructor, enrollment: 10)

    expect(eval.instructor).to eq(instructor)
  end

  describe "#create_if_needed_and_update" do
    let (:key_attrs) { {:term=>"2015C", :subject=>"CSCE", :course=>110, :section=>501} }
    let (:other_attrs) { {:instructor=> instructor , :enrollment=>24, :item1_mean=>4.46,
      :item2_mean=>4.46, :item3_mean=>4.46, :item4_mean=>4.08, :item5_mean=>4.46,
      :item6_mean=>4, :item7_mean=>3.85, :item8_mean=>4.38} }

    it "returns true if the record didn't exist" do
      expect(Evaluation.create_if_needed_and_update(key_attrs, other_attrs)).to be true
    end

    it "returns false if the record already existed" do
      Evaluation.create(key_attrs)
      expect(Evaluation.create_if_needed_and_update(key_attrs, other_attrs)).to be false
    end

    it "creates a new record if one does not already exist" do
      expect(Evaluation.all.count).to eq(0)
      Evaluation.create_if_needed_and_update(key_attrs, other_attrs)
      expect(Evaluation.all.count).to eq(1)
    end

    it "doesn't create a new record if one already exists" do
      Evaluation.create(key_attrs)
      expect(Evaluation.all.count).to eq(1)

      Evaluation.create_if_needed_and_update(key_attrs, other_attrs)
      expect(Evaluation.all.count).to eq(1)
    end
  end

  describe "#default_sorted_groups" do
    it "groups terms together" do
      g11 = Evaluation.create term: "2014C", subject: "CSCE", course: "110", section: "501", instructor: instructor
      g12 = Evaluation.create term: "2014C", subject: "CSCE", course: "110", section: "502", instructor: instructor
      g21 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "501", instructor: instructor
      g22 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "502", instructor: instructor

      expect(Evaluation.default_sorted_groups).to eq([[g11, g12], [g21, g22]])
    end

    it "groups subject together" do
      g11 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "501", instructor: instructor
      g12 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "502", instructor: instructor
      g21 = Evaluation.create term: "2015C", subject: "ENGR", course: "110", section: "501", instructor: instructor
      g22 = Evaluation.create term: "2015C", subject: "ENGR", course: "110", section: "502", instructor: instructor

      expect(Evaluation.default_sorted_groups).to eq([[g11, g12], [g21, g22]])
    end

    it "groups courses together" do
      g11 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "501", instructor: instructor
      g12 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "502", instructor: instructor
      g21 = Evaluation.create term: "2015C", subject: "CSCE", course: "111", section: "501", instructor: instructor
      g22 = Evaluation.create term: "2015C", subject: "CSCE", course: "111", section: "502", instructor: instructor

      expect(Evaluation.default_sorted_groups).to eq([[g11, g12], [g21, g22]])
    end

    it "groups 200s and 500s sections together" do
      g11 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "201", instructor: instructor
      g12 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "202", instructor: instructor
      g21 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "501", instructor: instructor
      g22 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "502", instructor: instructor

      expect(Evaluation.default_sorted_groups).to eq([[g11, g12], [g21, g22]])
    end

    it "groups instructors together" do
      instructor2 = Instructor.create(name: "Kevin Sumlin")
      g11 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "501", instructor: instructor2
      g12 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "502", instructor: instructor2
      g21 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "503", instructor: instructor
      g22 = Evaluation.create term: "2015C", subject: "CSCE", course: "110", section: "504", instructor: instructor

      expect(Evaluation.default_sorted_groups).to eq([[g11, g12], [g21, g22]])
    end
  end
end
