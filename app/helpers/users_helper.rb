module UsersHelper
  def posts?(posts)
    posts.count > 0
  end

  def comments?(comments)
    comments.count > 0
  end
end
