module PostsHelper

  def tag_links(tags)
    tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ")
  end

  def get_row_class(index)
    case index
    when 0
      style = 'small-12 medium-9 columns'
    when 1
      style = 'small-12 medium-3 columns'
    when 5
      style = 'small-12 medium-3 columns'
    when 6
      style = 'small-12 medium-9 columns'
    else
      style = 'small-12 medium-4 columns'
    end
    style
  end

end
