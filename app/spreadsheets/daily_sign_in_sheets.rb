class DailySignInSheets
  attr_accessor :courses

  def initialize
    @tuesday_courses = Section.where(day: "Tuesday") + Section.where(day: "Tuesday/Thursday")
    @thursday_courses = Section.where(day: "Thursday") + Section.where(day: "Tuesday/Thursday")
    @tuesday_students = []
    @thursday_students = []
    @tuesday_courses.each do |c|
      c.registrations.each do |r|
        @tuesday_students << r.student
      end
    end
    @thursday_courses.each do |c|
      c.registrations.each do |r|
        @thursday_students << r.student
      end
    end
    @thursday = {
      students: @thursday_students.sort_by! { |s| s.last_name.downcase }.uniq,
      name: "Thursday"
    }
    @tuesday = {
      students: @tuesday_students.sort_by! { |s| s.last_name.downcase }.uniq,
      name: "Tuesday"
    }
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    [@tuesday, @thursday].each do |t|
      sheet = book.create_worksheet name: t[:name]
      create_body sheet, t[:students]
    end

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string
  end

  def create_body sheet, students
    # Header row with a specific format
    sheet.row(0).concat %w{Student_Name}
    sheet.row(0).default_format = Spreadsheet::Format.new weight: :bold

    row_index = 1
    students.each do |s|
      sheet.row(row_index).concat [ s.full_name ]
      row_index += 1
    end

    row_index += 1
  end
end
