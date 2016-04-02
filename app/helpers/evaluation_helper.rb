module EvaluationHelper
  def compute_total_enrollment(group)
    group.inject(0) { |sum, eval| sum += eval.enrollment }
  end

  def compute_weighted_average_for_item(x, group)
    group.inject(0) { |sum, eval| sum += eval.enrollment * eval.send("item#{x}_mean".to_sym) } / compute_total_enrollment(group)
  end
end
