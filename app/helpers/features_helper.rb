module FeaturesHelper
  def version_added_parser(browser_info)
    # Simply the parser by converting hashes to an Array of length one.
    if (browser_info.kind_of?(Hash) || browser_info.nil?)
      array = Array.new(1)
      array[0] = browser_info
      browser_info = array
    end

    unless browser_info[0].nil?
      version_added = browser_info[0]['version_added']
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

    # If the support object has partial_implementation set to true, add a
    # CSS class to make the background yellow.
    if !browser_info[0].nil? && browser_info[0]['partial_implementation']
      content_tag_options[:class] += " bg-partial"
    end

    if !browser_info[0].nil? && browser_info[0]['version_removed'].present?
      content_tag_options[:class] += " bg-false"
      content_tag_options[:content] = "No"
    end

    return content_tag(
             content_tag_options[:tag_type],
             content_tag_options[:content],
             class: content_tag_options[:class],
             data: content_tag_options[:data]
           )
  end

  def browser_release_features(browser, version)
    return Feature.where("#{browser} @> ?", {'version_added': "#{version}"}.to_json).select("name, slug")
  end
end
