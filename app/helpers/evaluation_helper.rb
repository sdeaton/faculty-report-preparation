module EvaluationHelper
  def compute_total_enrollment(group)
    group.inject(0) { |sum, eval| sum += eval.enrollment }
  end

  def compute_weighted_average_for_item(x, group)
    group.inject(0) { |sum, eval| sum += eval.enrollment * eval.send("item#{x}_mean".to_sym) } / compute_total_enrollment(group)
  end

  def compute_mean_student_eval_score(group)
    (1..8).inject(0) { |sum, x| sum += compute_weighted_average_for_item(x, group) } / 8
  end
end
