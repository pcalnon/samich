FactoryGirl.define do

  factory :user do
    name                  "Dan Voss"
    username              "dvoss"
    email                 "dan.voss@ku.edu"
    password              "foobar"
    password_confirmation "foobar"
  end

  factory :group do
    name                  "ImLab"
    primary_investigator  "Wonpil Im"
    department            "Molecular Biosciences"
    office                "MULTIDISCIPLINARY RESEARCH BUILDING"
    phone                 "785-864-1993"
  end

  factory :job do
    job_id                "5884110"
    user_id               "1"
    queue_id              "1"
    name                  "STDIN"
    nodes_requested       "1"
    cores_requested       "1"
    attribute_requested  " "
    memory_requested      "100M"
    walltime_requested    "30:00:00"
    submit_flags          " "
    node_list             "n170/11"
    nodes_used            "1"
    cores_used            "1"
    memory_used           "100M"
    walltime_used         "00:04:29"
    submit_time           "Wed Jun 25 11:58:41 2014"
    start_time            "Wed Jun 25 11:58:42 2014"
    completion_time       "Wed Jun 25 12:03:11 2014"
  end

  factory :job_queue do
    name                  "long"
    description           "The long queue is used to run jobs that last over a week."
    walltime_default      "07:00:00:00"
    walltime_minimum      "07:00:00:00"
    walltime_maximum      " "
    memory_default        "2000M"
    memory_maximum        "132G"
    cores_default         "1"
    cores_maximum         "500"
  end

end

