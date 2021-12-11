require_relative '../../lib/webhook_event'
require_relative '../../lib/pull_request'
require_relative "../github_webhook_helpers"

RSpec.describe WebhookEvent do
  include GithubWebhookHelpers

  describe "#merged_pull_request" do
    it "returns true if the event was a close action and the pull request is merged" do
      body = create_event_params(action: "closed", pull_request: create_pull_request_params(merged: true))
      event = WebhookEvent.new(body)

      expect(event.merged_pull_request?).to be true
    end

    it "returns false if the event isn't the pull request being closed" do
      body = create_event_params(action: "opened", pull_request: create_pull_request_params(merged: true))
      event = WebhookEvent.new(body)

      expect(event.merged_pull_request?).to be false
    end

    it "returns false if the pull request is closed but not merged" do
      body = create_event_params(action: "closed", pull_request: create_pull_request_params(merged: false))
      event = WebhookEvent.new(body)

      expect(event.merged_pull_request?).to be false
    end
  end

  describe "#pull_request" do
    it "returns a PullRequest object" do
      pull_request = create_pull_request_params(
        title: "Add a new feature",
        merged: true
      )

      body = create_event_params(action: "opened", pull_request: pull_request)

      event = WebhookEvent.new(body)
      expect(event.pull_request).to have_attributes(
        class: PullRequest,
        title: "Add a new feature",
        merged?: true
      )
    end
  end
end
