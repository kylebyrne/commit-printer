require "json"

class WebhookEvent
  def initialize(body)
    @action = body[:action]
    @pull_request = body[:pull_request]
  end

  def merged_pull_request?
    @action == "closed" &&
      @pull_request[:merged]
  end
end
