class EvaluationController < ApplicationController
  def index
    @evaluations = Evaluation.all
  end

  def show
  end

  def export
    # export not implemented yet
    redirect_to evaluation_index_path
  end
end
