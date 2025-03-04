RSpec.describe "Podcasts requests", type: :requests do
  describe "GET /podcasts" do
    it "works"

    describe "response" do
      it "includes podcast"
      it "not includes draft podcast"

      it "provides podcast info"
    end
  end

  describe "POST /podcasts" do
    it "creates podcast"
    it "provides podcast info"

    context "when guest" do
      it "does not allow to create podcast"
    end

    context "when invalid params" do
      it "displays error"
      it "does not create podcast"
    end
  end

  describe "PATCH /podcasts/:id" do
    it "updates podcast"
    it "provides podcast info"

    context "when guest" do
      it "does not allow to update podcast"
    end

    context "when podcast of another user" do
      it "does not allow to update podcast"
    end
  end

  describe "POST /podcasts/:id/subscribe" do
    it "should subscribe user"
  end

  describe "POST /podcasts/:id/unsubscribe" do
    it "should unsubscribe user"
  end
end
