class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, presence: true
  validates :status, presence: true

  enum status: { pending: 'Pending', in_progress: 'In Progress', completed: 'Completed' }
  
end
