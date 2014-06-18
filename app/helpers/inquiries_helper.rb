module InquiriesHelper


  def get_status(status)
    if status
      'Abierto'
    else
      'Cerrado'
    end
  end

end
