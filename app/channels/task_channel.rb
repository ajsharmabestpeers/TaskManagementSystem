class TaskChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_for current_user
    # stream_from "task_#{params[:task_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
