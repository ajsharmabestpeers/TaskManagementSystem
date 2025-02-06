class Task < ApplicationRecord
  belongs_to :project
  belongs_to :user
  validates :name, presence: true
  validates :status, presence: true

  enum status: { pending: 'Pending', in_progress: 'In Progress', completed: 'Completed' }
  
  after_update_commit :broadcast_task_update

  private

  def broadcast_task_update
    # Broadcast the task update to the assigned user
    TaskChannel.broadcast_to(user, { task: self })
  end
end
