module ArticlesHelper
  def persisted_comments(comments)
    comments.reject{ |comment| comment.new_record? }
  end
end
