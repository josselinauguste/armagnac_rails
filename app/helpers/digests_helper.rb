module DigestsHelper
  def entry_title(entry)
    unless entry.title.blank?
      entry.title
    else
      'Titre vide'
    end
  end

  def entry_extract(entry)
    truncate_html(CGI.unescapeHTML(raw_content entry), length: 1024, omission: '&hellip;')
  end

  def blank_entry?(entry)
    strip_tags(CGI.unescapeHTML(raw_content entry)).blank?
  end

  private
  def raw_content(entry)
    entry.content || entry.summary || ''
  end
end
