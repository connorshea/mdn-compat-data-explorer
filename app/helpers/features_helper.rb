module FeaturesHelper
  def version_added_parser(browser_info)
    puts browser_info
    if browser_info.kind_of?(Array)
      version_added = browser_info[0]['version_added']
    elsif browser_info.kind_of?(Hash)
      version_added = browser_info['version_added']
    end

    # it would appear false values are changed to nil by Ruby at some point
    case version_added
      when true
        return content_tag(
                :td,
                "Yes",
                class: "bg-true text-center browser-support-info",
                data: {
                  support_json: browser_info,
                  toggle: "popover"
                }
               )
      when false
        return content_tag(
                :td,
                "No",
                class: "bg-false text-center browser-support-info",
                data: {
                  support_json: browser_info,
                  toggle: "popover"
                }
              )
      when nil
        return content_tag(
                :td,
                "?",
                class: "bg-unknown text-center browser-support-info",
                data: {
                  support_json: browser_info,
                  toggle: "popover"
                }
              )
      else
        return content_tag(
                :td,
                version_added,
                class: "bg-true text-center browser-support-info",
                data: {
                  support_json: browser_info,
                  toggle: "popover"
                }
              )
      end
  end
end
