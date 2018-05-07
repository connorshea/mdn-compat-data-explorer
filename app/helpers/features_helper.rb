module FeaturesHelper
  def version_added_parser(browser_info)
    if browser_info.kind_of?(Array)
      version_added = browser_info[0]['version_added']
    elsif browser_info.kind_of?(Hash)
      version_added = browser_info['version_added']
    end

    content_tag_options = {}

    # it would appear false values are changed to nil by Ruby at some point
    case version_added
      when true
        content_tag_options = {
          tag_type: :td,
          content: "Yes",
          class: "bg-true text-center browser-support-info",
          data: {
            support_json: browser_info
          }
        }
      when false
        content_tag_options = {
          tag_type: :td,
          content: "No",
          class: "bg-false text-center browser-support-info",
          data: {
            support_json: browser_info
          }
        }
      when nil
        content_tag_options = {
          tag_type: :td,
          content: "?",
          class: "bg-unknown text-center browser-support-info",
          data: {
            support_json: browser_info
          }
        }
      else
        content_tag_options = {
          tag_type: :td,
          content: version_added,
          class: "bg-true text-center browser-support-info",
          data: {
            support_json: browser_info
          }
        }
      end

    if browser_info.kind_of?(Array) && browser_info[0]['partial_implementation']
      content_tag_options[:class] += " bg-partial"
    elsif browser_info.kind_of?(Hash) && browser_info['partial_implementation']
      content_tag_options[:class] += " bg-partial"
    end

    return content_tag(
             content_tag_options[:tag_type],
             content_tag_options[:content],
             class: content_tag_options[:class],
             data: content_tag_options[:data]
           )
  end

  def browser_release_features(browser, version)
    return Feature.where("#{browser} @> ?", {'version_added': "#{version}"}.to_json)
  end
end
