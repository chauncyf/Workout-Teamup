require 'rqrcode'

class QrcodesController < ApplicationController
  def get
    qrcode = RQRCode::QRCode.new params[:url]
    send_data qrcode.as_png
  end
end