module ApplicationHelper
def title(site_title)
  content_for(:title) { site_title }
end

def meta_description(site_text)
  content_for(:meta_description) { site_text }
end

def meta_keywords(site_key)
  content_for(:meta_keywords) { site_key }
end
end
