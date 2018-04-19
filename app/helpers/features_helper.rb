module FeaturesHelper
  def version_added_parser(browser_info)
    if browser_info.kind_of?(Array)
      version_added = browser_info[0]['version_added']
    elsif browser_info.kind_of?(Hash)
      version_added = browser_info['version_added']
    end

    # it would appear false values are changed to nil by Ruby at some point
    case version_added
      when true
        return content_tag(:td, "Yes", class: "bg-true text-center")
      when false
        return content_tag(:td, "No", class: "bg-false text-center")
      when nil
        return content_tag(:td, "?", class: "bg-unknown text-center")
      else
        return content_tag(:td, version_added, class: "bg-true text-center")
      end
  end
end
