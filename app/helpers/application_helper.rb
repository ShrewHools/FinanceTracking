module ApplicationHelper
  def meta_tag(tag, text = DEFAULT_META[tag], opts = {})
    content = content_for("meta_#{tag}".to_sym) || text
    tag(:meta, { name: tag, content: content }.merge(opts)) if content
  end
end
