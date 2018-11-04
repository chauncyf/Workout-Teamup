module ApplicationCable
  class Channel < ActionCable::Channel::Base
    include SessionsHelper
  end
end
