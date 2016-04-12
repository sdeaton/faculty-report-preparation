require 'pdf-reader-turtletext'

class GradeDistributionReportImporter

  MATCHES = {
    section: /\A[A-Z]{4}-\d{3}-\d{3}\z/,
    gpr: /\A\d\.\d{3}\z/,
    instructor: /[a-zA-Z]+ [A-Za-z]/
  }

  TOLERANCE = 2

  def initialize(filename)
    @reader = PDF::Reader::Turtletext.new(filename)
  end

  def grades_hashes
    num_pages = reader.reader.page_count
    grades = []
    (1..num_pages).each do |num|
      grades += extract_grades_from_page(num)
    end
    grades.map do |grade|
      grade.delete(:x) # throw away the "x" value used for grabbing data from the PDF
      section_pieces = grade[:section].split("-") # section looks like "CSCE-111-501"
      {
        subject: section_pieces[0],
        course:  section_pieces[1],
        section: section_pieces[2],
        gpr:     grade[:gpr]
      }
    end
  end

  private
  def extract_grades_from_page(page_num)
    text_columns =
        @reader.
        content(page_num).           # Get raw data
        sort { |a, b| a[0] - b[0] }. # Sort them by their Y values
        map(&:last)                  # Ditch the Y values and just get the columns

    grades = []

    text_columns.each do |column|
      column.each do |x, data|
        case data
        when MATCHES[:section]
          grades.push({ section: data, x: x })
        when MATCHES[:gpr]
          grades.map do |gpr|
            if (gpr[:x] - x).abs < TOLERANCE
              gpr[:gpr] = data
            end
            gpr
          end
        when MATCHES[:instructor]
          grades.each do |gpr|
            if (gpr[:x] - x).abs < TOLERANCE
              gpr[:instructor] = data
              break
            end
          end
        end
      end
    end
    grades
  end

  def reader
    @reader
  end
end
