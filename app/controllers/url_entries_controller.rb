class UrlEntriesController < ApplicationController
  before_action :set_url_entry, only: %i[ show edit update destroy ]

  # GET /url_entries or /url_entries.json
  def index
    @url_entries = UrlEntry.all.active.order(sponsored: :desc)
  end

  # GET /url_entries/1 or /url_entries/1.json
  def show
  end

  def search
    keywords = settings_filter_chars(params[:query].split(' '))
    query_type = params[:query_type]
    sort_order = params[:sort_order]

    if query_type == 'AND'
      @url_entries = perform_and_search(keywords)
    elsif query_type == 'NOT'
      @url_entries = perform_not_search(keywords)
    else
      @url_entries = perform_or_search(keywords)
    end

    if sort_order == "counter"
      @url_entries = @url_entries.order(counter: :desc).order(sponsored: :desc)
    end
    if sort_order == "description"
      @url_entries = @url_entries.order(:description).order(sponsored: :desc)
    end

    @url_entries = @url_entries.active.sponsored_first
    
    respond_to do |format|
      format.html { @url_entries}
      format.json { render json: @url_entries }
    end

  end

  def visit
    @url_entry = UrlEntry.find(params[:id])
    @url_entry.increment
    redirect_to(@url_entry.url, allow_other_host: true)
  end

  # GET /url_entries/new
  def new
    @url_entry = UrlEntry.new
  end

  # GET /url_entries/1/edit
  def edit
  end

  # POST /url_entries or /url_entries.json
  def create
    @url_entry = UrlEntry.new(url_entry_params)

    
    respond_to do |format|
      if valid_url?(@url_entry.url) && @url_entry.save
        format.html { redirect_to url_entry_url(@url_entry), notice: "Url entry was successfully created." }
        format.json { render :show, status: :created, location: @url_entry }
      else
        @url_entry.errors.add(:url, message: "Failed to create URL Entry: check URL formatting")

        format.html { render :new, status: :unprocessable_entity}
        format.json { render json: @url_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /url_entries/1 or /url_entries/1.json
  def update
    respond_to do |format|
      if valid_url?(@url_entry.url) && @url_entry.update(url_entry_params)
        format.html { redirect_to url_entry_url(@url_entry), notice: "Url entry was successfully updated." }
        format.json { render :show, status: :ok, location: @url_entry }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @url_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /url_entries/1 or /url_entries/1.json
  def destroy

    @url_entry.update(archived:true)
    respond_to do |format|
      format.html { redirect_to url_entries_url, notice: "Url entry was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def settings_filter_chars(keywords)
      keywords = keywords.map { |keyword|
        Setting.first.filter_chars_array.each {|char|
          keyword = keyword.delete(char)
        }
        keyword
      }
      keywords = keywords.reject { |key| key.empty? }
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_url_entry
      @url_entry = UrlEntry.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def url_entry_params
      params.require(:url_entry).permit(:url, :description, :expire, :sponsored)
    end

    private

    def valid_url?(url)
      uri = URI.parse(url)
      uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
    rescue URI::InvalidURIError
      false
    end

    def perform_or_search(keywords)
      UrlEntry.where('description LIKE ?', "%#{keywords.first}%").tap do |query|
        keywords.drop(1).each do |keyword|
          query.or!(UrlEntry.where('description LIKE ?', "%#{keyword}%"))
        end
      end
    end
  
    def perform_and_search(keywords)
      UrlEntry.where('description LIKE ?', "%#{keywords.first}%").tap do |query|
        keywords.drop(1).each do |keyword|
          query.where!('description LIKE ?', "%#{keyword}%")
        end
      end
    end
  
    def perform_not_search(keywords)
      UrlEntry.where.not('description LIKE ?', "%#{keywords.first}%").tap do |query|
        keywords.drop(1).each do |keyword|
          query.where.not('description LIKE ?', "%#{keyword}%")
        end
      end
    end

end
