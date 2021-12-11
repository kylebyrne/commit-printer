module GithubWebhookHelpers
  def create_event_params(action:, pull_request:)
    {
      action: action,
      pull_request: pull_request
    }
  end

  def create_pull_request_params(merged: true, title: "Some title")
    {
      id: 800460692,
      number: 4,
      title: title,
      user:  {
        login: "kylebyrne",
        avatar_url: "https://avatars.githubusercontent.com/u/5172770?v=4",
      },
      body: "Pull request message and that",
      created_at: "2021-12-11T12:37:10Z",
      updated_at: "2021-12-11T12:37:17Z",
      closed_at: "2021-12-11T12:37:17Z",
      merged_at: "2021-12-11T12:37:17Z",
      merge_commit_sha: "a1e332cb2e44718b956bcea1bd5711c7032b3d84",
      labels: [],
      milestone: nil,
      draft: false,
      head:  { label: "kylebyrne:baz", ref: "baz", sha: "1ebee615969e12f00ba22bd6d26af4b157286030", },
      base:  { label: "kylebyrne:main", ref: "main", sha: "65d16127d4005a865a09ac1b5d8d5e6dc4ed50ba", },
      merged: merged,
      commits: 1,
      additions: 1,
      deletions: 1,
      changed_files: 1
    }
  end
end
