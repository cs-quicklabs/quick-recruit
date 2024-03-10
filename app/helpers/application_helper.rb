module ApplicationHelper
  include AvatarHelper
  include ButtonHelper
  include AutoLinkHelper

  include Pagy::Frontend

  def tailwind_form_with(**options, &block)
    form_with(**options.merge(builder: TailwindFormBuilder), &block)
  end

  def display_created_at(resource)
    display_date(resource.created_at)
  end

  def display_created_at_with_time(resource)
    resource.created_at.to_formatted_s(:long)
  end

  def display_date(date)
    date.to_date.to_formatted_s(:long)
  end

  def auto_link_urls_in_text(text)
    auto_link(text, html: { class: "text-indigo-700 hover:underline", target: "_blank" })
  end
end
