module PostHelper

  def get_comment_trie(comment)
    html = content_tag(:ul, class: "collection") {
      ul_contents = ""

      ul_contents << content_tag(:li, comment.body, class: "collection-item depth-#{comment.depth}")
      unless comment.replies.empty?
        comment.replies.each do |reply|
          ul_contents << get_comment_trie(reply)
        end
      end
      ul_contents.html_safe
    }.html_safe
  end

end
