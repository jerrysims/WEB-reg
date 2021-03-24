class ClassRostersReport
  attr_accessor :sections

  def initialize sections
    @sections = sections
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    @sections.each do |section|
      sheet_name = build_sheet_name section
      sheet = book.create_worksheet name: sheet_name
      create_body sheet, section
    end

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string
  end

  def create_body sheet, section
    # Header row with a specific format
    sheet.row(0).concat %w{Student Pronouns Email Grade section_Name Day/Time Parent_Name Parent_Email Learning_Differences Race Address}
    sheet.row(0).default_format = Spreadsheet::Format.new weight: :bold

    row_index = 1
    section.students.each do |s|
      sheet.row(row_index).concat [
        s.full_name, s.pronouns, s.student_email, s.grade, section.name,
        "#{section.day} #{section.start_time.strftime("%H:%M")}", s.parent.full_name,
        s.parent.email, s.learning_differences, s.race, s.mailing_address ]
      row_index += 1
    end

    row_index += 1
    sheet.row(row_index).concat [ "Class Count:", section.students.count ]
    sheet.row(row_index).default_format = Spreadsheet::Format.new weight: :bold
  end

  def build_sheet_name section
    name = section.name.sub("/", "-")
    day = section.day.sub("/", "_")
    time = section.start_time.strftime("%H%M")
    "#{name} #{day} #{time}"
  end
end
