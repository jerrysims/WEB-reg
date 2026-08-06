namespace :prod do
  EXCLUDED_DATES = %w[
    2026-10-13
    2026-10-15
    2026-11-03
    2026-11-24
    2026-11-26
    2026-12-15
    2026-12-17
    2026-12-22
    2026-12-24
    2026-12-29
    2026-12-31
    2027-03-23
    2027-03-25
  ].map { |date_string| Date.parse(date_string) }.freeze

  desc "Create SchoolDay records for every Tuesday and Thursday through April 29, 2027 in production"
  task seed_school_days: :environment do
    unless Rails.env.production?
      abort("This task is intended for production only.")
    end

    start_date = Date.current
    end_date = Date.new(2027, 4, 29)

    if start_date > end_date
      abort("Start date is after the configured end date.")
    end

    created_count = 0
    current_date = start_date

    while current_date <= end_date
      if ["Tuesday", "Thursday"].include?(current_date.strftime("%A")) && !EXCLUDED_DATES.include?(current_date)
        created_count += 1 unless SchoolDay.exists?(date: current_date)
        SchoolDay.find_or_create_for!(current_date)
      end

      current_date += 1.day
    end

    puts "School days ensured through #{end_date}."
    puts "New school days created: #{created_count}"
  end
end
