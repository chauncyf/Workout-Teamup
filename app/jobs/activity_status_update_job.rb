class ActivityStatusUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    #
    Activity.where()
  end
end
