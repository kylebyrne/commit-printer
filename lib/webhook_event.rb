require "json"
require_relative "pull_request"

class WebhookEvent
  def initialize(body)
    @action = body[:action]
    @pull_request = PullRequest.new(body[:pull_request])
  end

  def merged_pull_request?
    @action == "closed" && pull_request.merged?
  end

  def pull_request
    @pull_request
  end
end
