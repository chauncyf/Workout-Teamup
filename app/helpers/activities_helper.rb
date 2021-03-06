module ActivitiesHelper
  def get_activities params
    page = params[:page].to_i
    size = params[:size].to_i
    show_follows = params[:show_follows].to_i
    if params[:activity_type_ids].blank?
      activities = Activity.all
    else
      activities = Activity.where(activity_type_id: params[:activity_type_ids].split(","))
    end

    if show_follows == 1

      activities = activities.where(starter_id: current_user.followed)
    end

    unless params[:start_time].blank?
      activities = activities.where("activity_date >= ?", params[:start_time])
    end

    unless params[:end_time].blank?
      activities = activities.where("activity_date <= ?", params[:end_time])
    end
    activities.order(updated_at: :desc)
        .offset((page - 1) * size).limit(size)
  end

end

