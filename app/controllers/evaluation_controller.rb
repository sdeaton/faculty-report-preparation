class EvaluationController < ApplicationController
  def index
    @evaluations = Evaluation.all
  end

  def show
  end

  def export
  end
end
