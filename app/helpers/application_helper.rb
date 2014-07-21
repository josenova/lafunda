module ApplicationHelper

  def nav_link(link_text, link_path, link_id = "")
    class_name = current_page?(link_path) ? 'current' : nil
    #id_name = link_id.exists? ? 'link_id' : nil

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path, id: link_id
    end
  end

end
