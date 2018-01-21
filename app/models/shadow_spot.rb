class ShadowSpot < ActiveRecord::Base
  has_one :student_shadow
  has_one :student, through: :student_shadow
  belongs_to :subject
  has_one :teacher, through: :subject

  validates :time, presence: :true
  validates :date, presence: :true, uniqueness: { scope: [ :subject_id, :time ]}

  scope :unscheduled, -> { joins("LEFT OUTER JOIN student_shadows ON student_shadows.shadow_spot_id = shadow_spots.id").where("student_shadows.id IS null") }

  def name_for_select
    "#{subject.name}: #{date.strftime("%-m/%-d/%Y")}, #{time}"
  end

  def subject_grade
    subject.grade
  end
end
