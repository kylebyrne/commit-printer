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

  def merged_at
    DateTime.parse(@body.fetch(:merged_at))
  end

  def to_s
    <<~EOS
    commit #{@body.fetch(:merge_commit_sha)}
    Author: #{@body.dig(:user, :login)}
    Date:   #{merged_at.strftime("%a %b %d %H:%M:%S %Y %z")}
    +#{@body.fetch(:additions)} additions, -#{@body.fetch(:deletions)} deletions

    #{@body.fetch(:title)}

    #{@body.fetch(:body)}
    EOS
  end
end
