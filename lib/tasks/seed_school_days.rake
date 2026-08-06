namespace :dev do
  desc "Create SchoolDay records for every Tuesday and Thursday through April 29, 2027"
  task seed_school_days: :environment do
    unless Rails.env.development? || ENV["ALLOW_NON_DEV"] == "1"
      abort("This task is intended for local development only. Set ALLOW_NON_DEV=1 to override.")
    end

    start_date = Date.current
    end_date = Date.new(2027, 4, 29)

    if start_date > end_date
      abort("Start date is after the configured end date.")
    end

    created_count = 0
    current_date = start_date

    while current_date <= end_date
      if ["Tuesday", "Thursday"].include?(current_date.strftime("%A"))
        created_count += 1 unless SchoolDay.exists?(date: current_date)
        SchoolDay.find_or_create_for!(current_date)
      end

      current_date += 1.day
    end

    puts "School days ensured through #{end_date}."
    puts "New school days created: #{created_count}"
  end
end
