require 'rqrcode'

class QrcodesController < ApplicationController
  def get
    qrcode = RQRCode::QRCode.new(params[:id])
    send_data qrcode.as_png
  end
end