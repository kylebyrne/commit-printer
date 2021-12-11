class PullRequest
  def initialize(body)
    @body = body
  end

  def merged?
    @body.fetch(:merged, false)
  end

  def title
    @body.fetch(:title)
  end
end
