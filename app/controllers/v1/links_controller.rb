class V1::LinksController < V1::BaseController
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  def index
    @links = Link.all
    respond_to do |format|
      format.html
      format.json { render json: @links }
    end    
  end

  def show
    @shortened_url = @link.shortened_urls.first
    @short_url_trackings = ShortUrlTracking.short_url(@shortened_url.id)
  end

  def new
    @link = Link.new
  end

  def edit
  end

  def create
    @link = Link.new(link_params.merge({ip: request.remote_ip}))
    respond_to do |format|
      if @link.valid?
        Link.transaction do
          @link.save
          @shortened_url = @link.shortened_urls.generate(@link.original_url)  
        end
        format.html { redirect_to default_links_path, notice: 'Link was successfully created.' }
        format.json { render json: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to v1_links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.fetch(:link, {}).permit(:original_url, :title)
    end
end
