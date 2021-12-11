require_relative '../../lib/pull_request'
require_relative "../github_webhook_helpers"

RSpec.describe PullRequest do
  include GithubWebhookHelpers

  describe "#merged?" do
    it "returns true if the body has merged: true" do
      pull_request = PullRequest.new({ merged: true })
      expect(pull_request.merged?).to be true
    end

    it "returns false otherwise" do
      pull_request = PullRequest.new({ merged: false })
      expect(pull_request.merged?).to be false
    end
  end

  describe "#title" do
    it "returns the title of the pull request" do
      pull_request = PullRequest.new({ title: "Great new thing" })
      expect(pull_request.title).to eq "Great new thing"
    end
  end

  describe "#to_s" do
    it "returns a formatted description of the pull request" do
      body = <<~EOS
        Here's my new gift to the world of Ruby.
        It's a really great feature so I hope you enjoy it and use it wisely.
      EOS

      pull_request = create_pull_request_params(
        title: "Great new thing",
        author: "ted_lasso",
        sha: "a1e332cb2e44718b956bcea1bd5711c7032b3d84",
        body: body,
        merged_at: "2021-12-11T20:03:03Z",
        additions: 100,
        deletions: 3000,
      )

      message = PullRequest.new(pull_request).to_s

      expect(message.strip).to eq <<~EOS.strip
        commit a1e332cb2e44718b956bcea1bd5711c7032b3d84
        Author: ted_lasso
        Date:   Sat Dec 11 20:03:03 2021 +0000
        +100 additions, -3000 deletions

        Great new thing

        Here's my new gift to the world of Ruby.
        It's a really great feature so I hope you enjoy it and use it wisely.
      EOS
    end
  end
end
