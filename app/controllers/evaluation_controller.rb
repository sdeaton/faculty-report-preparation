class EvaluationController < ApplicationController
  def eval_params
    params.require(:evaluation).permit(:enrollment)
  end

  def evaluation_id
    params.require(:id)
  end

  def index
    @evaluation_groups = Evaluation.default_sorted_groups
    @terms = Evaluation.pluck(:term).uniq
  end

  def import
    render layout: "layouts/centered_form"
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

  # TODO: clean this up a little but. It should be easy to follow, but it's a little long.
  def upload
    importer = ::PicaReportImporter.new(params.require(:data_file))
    creation_results = importer.evaluation_hashes.map do |eval_attrs|
      key_attrs, other_attrs = split_attributes(eval_attrs)

      evaluation = Evaluation.where(key_attrs).first_or_initialize
      is_new_record = evaluation.new_record?
      evaluation.save

      evaluation.update(other_attrs)

      is_new_record
    end

    num_new_records = creation_results.count { |result| result == true }
    num_updated_records = creation_results.length - num_new_records

    flash[:notice] = "#{num_new_records} new evaluations imported. #{num_updated_records} evaluations updated."
    redirect_to evaluation_index_path
  end

  private
  def split_attributes(all_attrs)
      # key attributes are ones for which we should have one unique record for a set of them
      key_attributes = all_attrs.select { |k,v| [:term, :subject, :course, :section].include?(k) }

      # other atttributes are ones that should either be assigned or updated
      other_attributes = all_attrs.select { |k,v| ![:term, :subject, :course, :section].include?(k) }
      other_attributes[:instructor] = Instructor.where(name: other_attributes[:instructor]).first_or_create

      [ key_attributes, other_attributes ]
  end
end
