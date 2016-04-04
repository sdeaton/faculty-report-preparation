require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the EvaluationHelper. For example:
#
# describe EvaluationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe EvaluationHelper, type: :helper do
  describe "#compute_total_enrollment" do
    it "sums the enrollment of group of courses" do
      eval = FactoryGirl.create(:evaluation, enrollment: 50)
      eval2 = FactoryGirl.create(:evaluation, enrollment: 50)
      expect(helper.compute_total_enrollment([eval, eval2])).to eq(100)
    end
  end

  describe "#compute_weighted_average_for_item" do
    it "computes a weighted average for the specified evaluation question" do
      eval = FactoryGirl.create(:evaluation, enrollment: 50, item1_mean: 5.0)
      eval2 = FactoryGirl.create(:evaluation, enrollment: 50, item1_mean: 4.0)
      expect(helper.compute_weighted_average_for_item(1, [eval, eval2])).to be_within(0.0001).of(4.5)
    end
  end

  describe "#compute_mean_student_eval_score" do
    it "computes a weighted average for the specified evaluation question" do
      eval = FactoryGirl.create(:evaluation, enrollment: 50,
        item1_mean: 4.1, item2_mean: 4.1, item3_mean: 4.1, item4_mean: 4.1,
        item5_mean: 4.1, item6_mean: 4.1, item7_mean: 4.1, item8_mean: 4.1)
      eval2 = FactoryGirl.create(:evaluation, enrollment: 50,
        item1_mean: 3.9, item2_mean: 3.9, item3_mean: 3.9, item4_mean: 3.9,
        item5_mean: 3.9, item6_mean: 3.9, item7_mean: 3.9, item8_mean: 3.9)
      expect(helper.compute_mean_student_eval_score([eval, eval2])).to be_within(0.0001).of(4.0)
    end
  end
end
