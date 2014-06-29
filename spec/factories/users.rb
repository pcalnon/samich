FactoryGirl.define do

  factory :user do
    name                  "Dan Voss"
    username              "dvoss"
    email                 "dan.voss@ku.edu"
    password              "foobar"
    password_confirmation "foobar"
  end

end

