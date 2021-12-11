require_relative '../../lib/pull_request'

RSpec.describe PullRequest do
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
end
