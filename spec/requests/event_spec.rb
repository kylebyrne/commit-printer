require "json"
require_relative "../github_webhook_helpers"

RSpec.describe "POST /event" do
  include GithubWebhookHelpers

  let(:printer) { double(Printer, print: nil) }

  before do
    app.opts[:printer] = printer
  end

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

  it "prints out the pull request information" do
    pull_request = create_pull_request_params(
      merged: true,
      title: "Great new thing",
      author: "ted_lasso",
      sha: "a1e332cb2e44718b956bcea1bd5711c7032b3d84",
      body: "Some really important work",
      merged_at: "2021-12-11T20:03:03Z",
      additions: 100,
      deletions: 3000,
    )
    expcted_output = PullRequest.new(pull_request).to_s

    post "/event", create_event_params(action: "closed", pull_request: pull_request).to_json

    expect(printer).to have_received(:print).with(expcted_output)
  end
end
