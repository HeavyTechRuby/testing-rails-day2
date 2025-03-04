RSpec.describe "Episodes requests", type: :requests do
  describe "GET /podcasts/:podcast_id/episodes" do
    it "works"

    describe "response" do
      it "includes episode"
      it "not includes draft episode"

      it "provides episode info"
    end
  end

  describe "POST /podcasts/:id/episodes" do
    it "creates episode"
    it "provides episode info"

    context "when guest" do
      it "does not allow to create episode"
    end

    context "when invalid params" do
      it "displays error"
      it "does not create episode"
    end
  end

  describe "PATCH /podcasts/:id/episode/:id" do
    it "updates episode"
    it "provides episode info"

    context "when guest" do
      it "does not allow to update episode"
    end

    context "when episode of another user" do
      it "does not allow to update episode"
    end
  end

  describe "POST /podcasts/:podcast_id/episodes/:id/like" do
    it "should like episode"
  end

  describe "POST /podcasts/:podcast_id/episodes/:id/like" do
    it "should unlike episode"
  end
end

