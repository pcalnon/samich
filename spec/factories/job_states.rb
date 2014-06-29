# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :job_state do
    job_id                "5884110"
    user_id               "1"
    queue_id              "1"
    name                  "STDIN"
    status                "Running"
    nodes_requested       "1"
    cores_requested       "1"
    attribute_requested   ":del_int_16_64"
    memory_requested      "100M"
    walltime_requested    "30:00:00"
    submit_flags          "-I"
    node_list             "n170/11"
    nodes_used            "1"
    cores_used            "1"
    memory_used           "100M"
    walltime_used         "00:04:29"
    submit_time           "Wed Jun 25 11:58:41 2014"
    start_time            "Wed Jun 25 11:58:42 2014"
    completion_time       "Wed Jun 25 12:03:11 2014"
  end
end
