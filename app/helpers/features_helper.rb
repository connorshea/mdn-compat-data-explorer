module FeaturesHelper
  def version_added_parser(browser_info)
    if browser_info.kind_of?(Array)
      return browser_info[0]['version_added']
    elsif browser_info.kind_of?(Array)
      return browser_info['version_added']
    end
  end
end
