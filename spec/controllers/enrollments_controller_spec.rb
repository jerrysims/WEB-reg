require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:parent) { create(:parent) }
  before { sign_in parent }

  describe 'instance method' do
    describe '#new' do
      context 'when parent already has students' do
        let!(:student) { create(:student, parent: parent) }

        context 'but the parameter is not present' do

          it "redirects_to :action => :select_student" do
            get :new
            expect(subject).to redirect_to :action => :select_student
          end
        end

        context 'and the parameter is present' do
          it "loads the new enrollment form" do
            get :new, { student_id: student.id}

            expect(response).to render_template(:new)
          end
        end
      end

      context 'when parent does not yet have students' do
        it 'loads the new enrollment form' do
          get :new

          expect(response).to render_template(:new)
        end
      end
    end

    describe '#select_student' do
      it 'loads the select_student template' do
        get :select_student

        expect(response).to render_template(:select_student)
      end
    end

    describe '#student_info' do
      
    end
  end
end
