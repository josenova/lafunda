module InquiriesHelper


  def get_status(status)
    if status
      t('views.open')
    else
      t('views.closed')
    end
  end

end
