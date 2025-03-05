class PodcastsController < ApplicationController
  #before_action :set_podcast, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: %i[ create ]

  # GET /podcasts or /podcasts.json
  def index
    @podcasts = Podcast.published
  end

  # GET /podcasts/1 or /podcasts/1.json
  def show
  end

  # GET /podcasts/new
  def new
    @podcast = Podcast.new
  end

  # GET /podcasts/1/edit
  def edit
  end

  # POST /podcasts or /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)

    respond_to do |format|
      if @podcast.save
        response.headers["X-Location-Url"] = podcast_url(@podcast)
        format.html { redirect_to @podcast, notice: "Podcast was successfully created." }
        format.json { render :show, status: :created, location: @podcast }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1 or /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: "Podcast was successfully updated." }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1 or /podcasts/1.json
  def destroy
    @podcast.destroy!

    respond_to do |format|
      format.html { redirect_to podcasts_path, status: :see_other, notice: "Podcast was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def podcast_params
      params.expect(podcast: [ :title, :author_id ])
    end
end
