module ApplicationHelper


  def nav_link(link_text, link_path, link_id = "")
    class_name = current_page?(link_path) ? 'current' : nil
    content_tag(:li, :class => class_name, id: link_id) do
      link_to link_text, link_path
    end
  end


  #Show pending inquiries.
  def inquiry_alert
    @pending_inquiries = Inquiry.where(status: true).count
    if @pending_inquiries > 0
      content_tag(:span) do
        @pending_inquiries.to_s
      end
    end
  end


end
