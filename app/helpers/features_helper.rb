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
        return "Yes"
      when false
        return "No"
      when nil
        return "?"
      else
        return version_added
      end
  end
end
