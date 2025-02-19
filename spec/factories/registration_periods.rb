FactoryBot.define do
  factory :registration_period do
    name { "2024-25 Academic Year" }
    open_date { Date.today }
    close_date { Date.today + 3.months }
    rp_type { "academic" }
    semester { "Fall" }
    status { "future" }

    trait :academic do
      rp_type { "academic" }
    end

    trait :extracurricular do
      rp_type { "extracurricular" }
    end

    trait :open do
      open_date { Date.today - 1.day }
      close_date { Date.today + 1.month }
      status { "all" }
    end

    trait :closed do
      open_date { Date.today - 2.months }
      close_date { Date.today - 1.day }
      status { "closed" }
    end

    trait :teachers do
      status { "teachers" }
    end

    trait :returning do
      status { "returning" }
    end

    factory :current_academic_year do
      name { "2023-24 Academic Year" }
    end

    factory :future_registration_period do
      open_date { Date.today + 1.month }
      close_date { Date.today + 4.months }
      status { "future" }
    end
  end
end