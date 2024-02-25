module ApplicationHelper
  include AvatarHelper
  include ButtonHelper

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
end
