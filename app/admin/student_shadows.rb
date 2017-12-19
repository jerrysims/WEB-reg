ActiveAdmin.register StudentShadow do
  index do |student_shadows|
    column "Student" do |ss|
      ss.student.full_name
    end
    column "Date" do |ss|
      ss.shadow_spot.date.strftime("%-m/%-d/%Y")
    end
    column "Time" do |ss|
      ss.shadow_spot.time
    end
    column "Subject" do |ss|
      ss.shadow_spot.subject.name
    end
    column "Grade" do |ss|
      ss.student.grade
    end
  end
end
