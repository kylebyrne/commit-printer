require "roda"
require_relative "lib/webhook_event"

class App < Roda
  route do |r|
    r.get "ping" do
      response.status = 200
      "We gucci"
    end

    r.post "event" do
      body = JSON.parse(request.body.read, symbolize_names: true)
      event = WebhookEvent.new(body)

      if event.merged_pull_request?
        response.status = 200
        return
      end

      response.status = 204
      nil
    end
  end
end
