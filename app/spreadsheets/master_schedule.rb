class MasterSchedule
  attr_accessor :courses

  def initialize(rp)
    @rp = rp
    @start_times = {}
    @start_times[:Tuesday] = (Section.in_period(rp).where(day: "Tuesday") + Section.where(day: "Tuesday/Thursday")).pluck(:start_time).uniq.sort
    @start_times[:Thursday] = (Section.in_period(rp).where(day: "Thursday") + Section.where(day: "Tuesday/Thursday")).pluck(:start_time).uniq.sort
    @students = Student.enrolled(rp).order(:last_name)
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet name: "Master Schedule"
    create_body sheet

    data_to_send = StringIO.new
    book.write data_to_send
    data_to_send.string
  end

  def create_body sheet
    # Header row with a specific format

    sheet.row(0).concat column_headers
    sheet.row(0).default_format = Spreadsheet::Format.new weight: :bold

    row_index = 1
    @students.each do |s|
      sheet.row(row_index).concat get_student_row(s)
      row_index += 1
    end

    row_index += 1
  end

  def column_headers
    headers = ["Student First", "Student Last", "Grade Level", "Race", "Pronouns", "Zip Code", "Student Email", "Parent First", "Parent Last", "Parent Phone", "Parent Email"]
    @start_times.each do |k, v|
      v.each do |time|
        headers << "#{k} #{time.strftime("%l:%M")}"
      end
    end
    headers
  end

  def get_student_row(student)
    row = [
      student.first_name,
      student.last_name,
      student.grade,
      student.race,
      student.pronouns,
      student.parent.zip_code,
      student.student_email,
      student.parent.first_name,
      student.parent.last_name,
      student.parent.phone_number,
      student.parent.email
    ]
    @start_times.each do | day, t |
      t.each do |start_time|
        cell_value = student.sections.in_period(@rp).find_by(day: [day.to_s, "Tuesday/Thursday"], start_time: start_time).try(:name) ||
                     "-------"
        row << cell_value
      end
    end
    row
  end
end
