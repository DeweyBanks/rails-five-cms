module PostsHelper

  def tag_links(tags)
    tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ")
  end

  def get_first_row_class(index, row)
    if row == 1
      if index == 0
        style = 'small-9 columns'
      else
        style = 'small-3 columns'
      end
    else
      if index == 0
        style = 'small-3 columns'
      else
        style = 'small-9 columns'
      end
    end
    style
  end

end
