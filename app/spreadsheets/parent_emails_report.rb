class ParentEmailsReport
  attr_accessor :courses

  def initialize
    @parents = Parent.all.sort_by { |p| p.full_name }
  end

  def generate_xls
    book = Spreadsheet::Workbook.new
    sheet = book.create_worksheet name: "Parent Emails"
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

    @parents.each do |p|
      sheet.row(row_index).concat get_parent_row(p)
      row_index += 1
    end

    row_index += 1
  end

  def column_headers
    headers = ["Registered Parent", "Email", "Secondary Email"]
    headers
  end

  def get_parent_row(parent)
    row = [
      parent.full_name,
      parent.email,
      parent.secondary_email,
    ]
  end
end
