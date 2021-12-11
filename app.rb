require "roda"

class App < Roda
  route do |r|
    r.get "ping" do
      response.status = 200
      "We gucci"
    end
  end
end
