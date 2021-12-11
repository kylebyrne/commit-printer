RSpec.describe "GET /ping" do
  it "returns a 200 status code and lets you know we all good" do
    get "/ping"

    expect(last_response.status).to eq(200)
    expect(last_response.body).to eq("We gucci")
  end
end
