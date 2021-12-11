RSpec.describe "Hello" do
  it "says hello" do
    get "/"
    expect(last_response.body).to eq("Hello World!")
  end
end
