class SearchedPostQuery
  def initialize(params = {}, relation = Post.all)
    @relation = relation
    @params = params
  end

  def all
    @relation.public_send(search_by).where("LOWER(posts.title) LIKE LOWER(?)", search)
  end

  private
  def search
    @params[:search] != nil ? "%" + @params[:search] + "%" : "%"
  end

  def search_by
    @params[:search] != nil ? 'by_title' : 'nothing'
  end
end