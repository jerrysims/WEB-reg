FactoryBot.define do
  factory :section do
    day { "MyText" }
    start_time { "2018-02-22 10:22:49" }
    end_time { "2018-02-22 10:22:49" }
    class_minimum { 12 }
    class_maximum { 18 }
    course
  end
end
