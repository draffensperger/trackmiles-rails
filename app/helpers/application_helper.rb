module ApplicationHelper
  # Thanks to https://gist.github.com/roberto/3344628
  def bootstrap_class_for flash_type
    case flash_type
      when :success
        "alert-success"
      when :error
        "alert-error"
      when :alert
        "alert-block"
      when :notice
        "alert-info"
      else
        flash_type.to_s
    end
  end
  
  def nav_link(link_text, link_path)
    params = current_page?(link_path) ? {class: 'active'} : {}     
    content_tag(:li, params) do
      link_to link_text, link_path
  end
end
end
