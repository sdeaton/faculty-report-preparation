class EvaluationController < ApplicationController
  def eval_params
    params.require(:evaluation).permit(:enrollment)
  end

  def evaluation_id
    params.require(:id)
  end

  def index
    @evaluations = Evaluation.all
  end

  def show
	@evaluation = Evaluation.find(evaluation_id)
  end

  def export
    # export not implemented yet
    redirect_to evaluation_index_path
  end

  def edit
	@evaluation = Evaluation.find(evaluation_id)
  end

  def update
  @evaluation = Evaluation.find(evaluation_id)
  @evaluation.update_attributes!(eval_params)
  flash[:notice] = "updated"
    redirect_to evaluation_index_path
  end
end
