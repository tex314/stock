module ApplicationHelper
  def tag_cloud(tags, classes)
    max = 0
    tags.each do |t|
      if t.count.to_i > max
        max = t.count.to_i
      end
    end
    tags.each do |tag|
      index = tag.count.to_f / max * (classes.size - 1)
      yield(tag, classes[index.round])
    end
  end

  def flash_notifications
    message = flash[:error] || flash[:notice]

    if message
      type = flash.keys[0].to_s
      javascript_tag %Q{$.notification({ message:"#{message}", type:"#{type}" });}
    end
  end
end
