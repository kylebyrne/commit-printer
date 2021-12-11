require "json"
require_relative "../github_webhook_helpers"

RSpec.describe "POST /event" do
  include GithubWebhookHelpers
  it "returns a 200 status code when the event is a merged pull request" do
    pull_request = create_pull_request_params(merged: true)

    post "/event", create_event_params(action: "closed", pull_request: pull_request).to_json
    expect(last_response.status).to eq(200)
  end

  it "returns a 204 status code for any other event" do
    pull_request = create_pull_request_params(merged: false)

    post "/event", create_event_params(action: "opened", pull_request: pull_request).to_json
    expect(last_response.status).to eq(204)
  end
end
