require 'rubyXL'

class PicaReportImporter

  class MalformedFileException < RuntimeError
    def to_s
      "Your file appears to be invalid. Please make sure each of the columns are present: " +
          ::PicaReportImporter::DESIRED_DATA.map(&:to_s).join(", ")
    end
  end

  # These are symbolized version of the expected column headings of all the data we care about.
  # TODO: in the future, it might be nice to make these configurable by the user
  DESIRED_DATA = [
    :term, :subject, :course, :sect, :instructor, :enrollment,
    :item1_mean, :item2_mean, :item3_mean, :item4_mean,
    :item5_mean, :item6_mean, :item7_mean, :item8_mean
  ]

  RENAMES = { :sect => :section }

  def initialize(uploaded_file)
    # TODO: check for wrong filetype here
    @workbook = RubyXL::Parser.parse_buffer(uploaded_file)
  end

  def import
    @results = evaluation_hashes.map do |eval_attrs|
      key_attrs, other_attrs = split_attributes(eval_attrs)

      case key_attrs[:subject]
      when 'CSCE'
        is_new = Evaluation.create_if_needed_and_update(key_attrs, other_attrs)
        { status: is_new }
      when 'ENGR'
        inst = Instructor.where(name: other_attrs[:instructor]).first
        if inst
          is_new = Evaluation.create_if_needed_and_update(key_attrs, other_attrs)
          { status: is_new }
        else
          { status: :failure }
        end
      else
        { status: :failure }
      end
    end
  end

  def results
    num_new_records = @results.count { |result| result[:status] == true }
    num_updated_records = @results.count { |result| result[:status] == false }
    num_failed_records = @results.count { |result| result[:status] == :failure }

    { created: num_new_records, updated: num_updated_records, failed: num_failed_records }
  end

  def evaluation_hashes
    @evaluation_hashes ||= parse_sheet
  end

  def parse_sheet
    sheet = @workbook.first

    # figure out the columns of the data from the headers
    column_header_indices = {}
    sheet[0].cells.each_with_index do |cell, i|
      column_header_indices[cell.value.downcase.to_sym] = i
    end

    evaluations = []

    sheet.each_with_index do |row, row_num|
      # skip the first row. It's just column headings
      next if row_num == 0

      evaluation = {}
      DESIRED_DATA.each do |data_type|
        row_index = column_header_indices[data_type]
        raise MalformedFileException.new if row_index.nil?
        cell = row.cells[row_index]

        data_type = RENAMES[data_type] if RENAMES[data_type]
        evaluation[data_type] = cell && cell.value
      end

      evaluations.push(evaluation) if evaluation.values.reject(&:nil?).size > 0
    end

    evaluations
  end


  def split_attributes(all_attrs)
      # key attributes are ones for which we should have one unique record for a set of them
      key_attributes = all_attrs.select { |k,v| Evaluation.key_attributes.include?(k.to_sym) }

      # other atttributes are ones that should either be assigned or updated
      other_attributes = all_attrs.reject { |k,v| Evaluation.key_attributes.include?(k.to_sym) }

      [ key_attributes, other_attributes ]
  end
end
