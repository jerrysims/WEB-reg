class MasterSchedule
  attr_accessor :courses

  def initialize
    @start_times = {}
    @start_times[:Tuesday] = (Course.where(day: "Tuesday") + Course.where(day: "Tuesday/Thursday")).pluck(:start_time).uniq.sort
    @start_times[:Thursday] = (Course.where(day: "Thursday") + Course.where(day: "Tuesday/Thursday")).pluck(:start_time).uniq.sort
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
    Student.all.sort_by { |s| s.full_name.downcase }.each do |s|
      sheet.row(row_index).concat get_student_row(s)
      row_index += 1
    end

    row_index += 1
  end

  def column_headers
    headers = ["Student Name"]
    @start_times.each do |k, v|
      v.each do |time|
        headers << "#{k} #{time.strftime("%l:%M")}"
      end
    end
    headers
  end

  def get_student_row(student)
    row = [student.full_name]
    @start_times.each do | day, t |
      t.each do |start_time|
        cell_value = student.courses.where(day: day.to_s).where(start_time: start_time).first.try(:name) || "-----"
        row << cell_value
      end
    end
    row
  end
end
