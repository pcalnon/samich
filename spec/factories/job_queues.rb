FactoryGirl.define do

  factory :job_queue do
    name                  "long"
    description           "The long queue is used to run jobs that last over a week."
    walltime_default      "07:00:00:00"
    walltime_minimum      "07:00:00:00"
    walltime_maximum      "365:00:00:00"
    memory_default        "2000M"
    memory_maximum        "132G"
    cores_default         "1"
    cores_maximum         "500"
  end

end

