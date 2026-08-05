require 'rails_helper'

RSpec.describe AttendanceEntry, type: :model do
  describe '.statuses_for_select' do
    it 'returns all valid statuses as human-readable label/value pairs' do
      expect(described_class.statuses_for_select).to eq(
        [
          ['Not yet reported', 'not_yet_reported'],
          ['Present', 'present'],
          ['Absent', 'absent'],
          ['Tardy', 'tardy'],
          ['Early dismissal', 'early_dismissal']
        ]
      )
    end
  end
end
