require "roda"
require_relative "lib/webhook_event"
require_relative "lib/printer"
require 'logger'

class App < Roda
  opts[:logger] = Logger.new(STDOUT)
  opts[:printer] = Printer.new("/dev/serial0", 19200)

  route do |r|
    r.get "ping" do
      response.status = 200
      opts[:logger].info("HEALTH CHECK")
      "We gucci"
    end

    r.post "event" do
      body = JSON.parse(request.body.read, symbolize_names: true)
      event = WebhookEvent.new(body)

      if event.merged_pull_request?
        response.status = 200

        opts[:logger].info(event.pull_request.to_s)
        opts[:printer].print(event.pull_request.to_s)
        return
      end

      response.status = 204
      nil
    end
  end
end
