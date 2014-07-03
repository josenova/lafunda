module InquiriesHelper


  def get_status(status)
    if status
      t('views.open')
    else
      t('views.closed')
    end
  end

  def is_employee(entry)
    if entry.employee
      "employee"
    else
      "user"
    end
  end

end
