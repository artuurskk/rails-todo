class TasksChannel < ApplicationCable::Channel
  def subscribed
    stream_from "tasks"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
