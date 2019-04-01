class ClassRostersReport
  attr_accessor :courses

  def initialize courses
    @courses = courses
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    @courses.each do |course|
      sheet_name = build_sheet_name course
      sheet = book.create_worksheet name: sheet_name
      create_body sheet, course
    end

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string
  end

  def create_body sheet, course
    # Header row with a specific format
    sheet.row(0).concat %w{Student Grade Course_Name Day/Time Parent_Name Parent_Email Learning_Differences}
    sheet.row(0).default_format = Spreadsheet::Format.new weight: :bold

    row_index = 1
    course.students.each do |s|
      sheet.row(row_index).concat [ s.full_name, s.grade, course.name, "#{course.day} #{course.start_time.strftime("%H:%M")}", s.parent.full_name, s.parent.email, s.learning_differences ]
      row_index += 1
    end
  end

  def build_sheet_name course
    name = course.name.sub("/", "-")
    day = course.day.sub("/", "_")
    time = course.start_time.strftime("%H%M")
    "#{name} #{day} #{time}"
  end
end
