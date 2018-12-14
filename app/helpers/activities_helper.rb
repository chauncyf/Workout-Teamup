module ActivitiesHelper
  def get_activities params
    page = params[:page].to_i
    size = params[:size].to_i
    if params[:activity_type_ids].blank?
      activities = Activity.all
    else
      activities = Activity.where(activity_type_id: params[:activity_type_ids].split(","))
    end
    activities.order(updated_at: :desc)
        .offset((page - 1) * size).limit(size)
  end
end
