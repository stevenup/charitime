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

  # Render the active class
  def render_active(ori_hash)
    ul, li = ori_hash[:ul], ori_hash[:li]
    hash = {
      :ul => {
        'products' => ['admin/products'],
      },
      :li => {
        'products' => ['index'],
      }
    }
    puts params[:controller]
    return if hash[:ul][ul].nil? && hash[:li][li].nil?
    if li.nil?
      return 'open' if hash[:ul][ul].include? params[:controller]
    elsif ul && li
      return if ul != params[:controller].split('/')[1]
      return 'active' if hash[:li][ul].include? li
    end
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
