class JobQueue < ActiveRecord::Base
  before_save { self.name = name.downcase }
  validates(:name, presence: true, uniqueness: { case_sensitive: false })
  validates(:walltime_default, presence: true)
  validates(:memory_default, presence: true)
  validates(:memory_maximum, presence: true)
  validates(:cores_default, presence: true)
  validates(:cores_maximum, presence: true)
end
