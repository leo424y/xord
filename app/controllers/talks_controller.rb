class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  # GET /talks
  # GET /talks.json
  def index
    session[:page] = 'index'
    @talks=[]
    @talks << Talk.order(id: :desc).first(3)
    @talks << Talk.order(id: :desc).limit(20).sample(1)
    @talks << Talk.where(created_at: Time.now-0.5.hour..Time.now-0.25.hour).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-1.hour..Time.now-0.5.hour).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-2.hour..Time.now-1.hour).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-2.day..Time.now-1.day).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-1.week-1.day..Time.now-1.week).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-1.month-1.day..Time.now-1.month).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-3.month-1.day..Time.now-3.month).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-6.month-1.day..Time.now-6.month).order(id: :desc).sample(3)
    @talks << Talk.where(created_at: Time.now-1.year-1.day..Time.now-1.year).order(id: :desc).sample(3)
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  # GET /talks/new
  def new
    @talk = Talk.new
    session[:page] = 'new'
  end

  # GET /talks/1/edit
  # def edit
  # end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(talk_params)

    respond_to do |format|
      if @talk.save
        format.html { redirect_to talks_path, notice: 'Talk was successfully created.' }
        format.json { render :show, status: :created, location: @talk }
      else
        format.html { render :new }
        format.json { render json: @talk.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /talks/1
  # PATCH/PUT /talks/1.json
  # def update
  #   respond_to do |format|
  #     if @talk.update(talk_params)
  #       format.html { redirect_to @talk, notice: 'Talk was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @talk }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @talk.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /talks/1
  # DELETE /talks/1.json
  def destroy
    @talk.destroy
    respond_to do |format|
      format.html { redirect_to talks_url, notice: 'Talk was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_talk
      @talk = Talk.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def talk_params
    if	session[:page] == 'new'
      params.require(:talk).permit(:topic, :from)
    elsif session[:page] == 'index'
      params.permit(:topic, :from)
    end
    end
end
