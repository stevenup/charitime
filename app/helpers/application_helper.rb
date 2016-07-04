module ApplicationHelper
  # Include controller specific javascript file
  #
  # * <tt>action_name</tt> - Optional, action name of the js file, should actually be the filename
  #   of the file need to be included, if not specified, current action name will beused
  def controller_js_include(action_name = nil)
    javascript_include_tag "controllers/#{params[:controller]}/#{action_name || params[:action]}"
  end

  # Include controller specific stylesheet file
  #
  # * <tt>action_name</tt> - Optional, action name of the css file, should actually be the filename
  #   of the file need to be included, if not specified, current action name will beused
  def controller_css_include(action_name = nil)
    stylesheet_link_tag "controllers/#{params[:controller]}/#{action_name || params[:action]}"
  end

  # Render the active sidebar menu
  #
  def render_active(opts)
    menu = opts.delete :menu
    return 'active' if menu == params[:controller].split('/')[1] || menu == params[:action]
  end

  # 创建一个timeago插件兼容的时间戳显示tag
  def timeago(time, options = {})
    options[:class]
    options[:class] = options[:class].blank? ? "timeago" : [options[:class],"timeago"].join(" ")
    options[:'data-toggle'] = 'tooltip'
    options[:'data-container'] = 'body'
    content_tag(:abbr, "", options.merge(:title => format_datetime2(time))) if time
  end
end
