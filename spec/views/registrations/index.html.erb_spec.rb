# require 'rails_helper'

# RSpec.describe "registrations/index.html.erb", type: :view do
#   include Devise::Test::ControllerHelpers

#   let(:registration_period) { create(:registration_period) }
#   let(:parent) { create(:parent) }
#   let(:student) { create(:student, parent: parent) }
#   let(:course) { create(:course, registration_period: registration_period) }
#   let(:section1) { create(:section, course: course, class_maximum: 20) }
#   let(:section2) { create(:section, course: course, class_maximum: 20) }
#   let(:fee_product1) { create(:product, product_type: 'fee', unit_price: 50, registration_period: registration_period) }
#   let(:fee_product2) { create(:product, product_type: 'fee', unit_price: 30, registration_period: registration_period) }

#   before do
#     course.products << fee_product1
#     course.products << fee_product2
#     student.registrations.create(section: section1, status: 'registered')
#     student.registrations.create(section: section2, status: 'registered')
#     assign(:student, student)
#     assign(:rp, registration_period)
#     assign(:days, %w[Monday Tuesday])
#     assign(:time_blocks, {
#       Monday: { morning: { label_text: 'Morning', sections: [section1] } },
#       Tuesday: { afternoon: { label_text: 'Afternoon', sections: [section2] } }
#     })
#     sign_in parent
#     render
#   end

#   it "displays the correct invoice total" do
#     total_fees = fee_product1.unit_price + fee_product2.unit_price
#     expect(rendered).to have_css("span#course-fees", text: "$#{total_fees}")
#   end
# end
