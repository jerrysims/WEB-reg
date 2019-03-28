ActiveAdmin.register Course, as: "Class Rosters" do
  menu parent: "Reports"

  filter :name, as: :select

  index do |course|
    column :name
    column do |course|
      unless course.registrations.empty?
        table_for course.registrations do
          column "Class Roster" do |registration|
            registration.student.full_name
          end
        end
      end
    end
  end

  csv do
    column "Course Name / Time" do |c|
      "#{c.name}, #{c.start_time}"
    end
    column "Students" do |c|
      c.registrations.map { |r| r.student.full_name }
    end
  end
end
