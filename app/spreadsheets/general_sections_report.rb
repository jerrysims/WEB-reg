class GeneralSectionsReport
  attr_accessor :sections

  def initialize
    @sections = Section.all
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet name: "Sections"
    create_body sheet, @sections

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string
  end

  def create_body sheet, sections
    # Header row with a specific format
    sheet.row(0).concat %w( Course Day Time Student_Count )
    sheet.row(0).default_format = Spreadsheet::Format.new weight: :bold

    row_index = 1
    sections.each do |s|
      sheet.row(row_index).concat [ s.course.name, s.day, s.start_time.strftime("%l:%M"), s.students.count ]
      row_index += 1
    end
  end
end
