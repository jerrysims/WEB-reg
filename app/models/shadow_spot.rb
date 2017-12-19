class ShadowSpot < ActiveRecord::Base
  has_one :student_shadow
  has_one :student, through: :student_shadow
  belongs_to :subject
  has_many :teachers
  # belongs_to :student

  validates :time, presence: :true
  validates :date, presence: :true, uniqueness: { scope: [ :subject, :time ]}

  def name_for_select
    "#{subject.name}: #{date.strftime("%-m/%-d/%Y")}, #{time}"
  end

  def subject_grade
    subject.grade
  end
end
