class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  # GET /talks
  # GET /talks.json
  def index
    session[:page] = 'index'
    @talks=[]
    @parent_ids = []
    @talks << Talk.order(id: :desc).first(3)
    # @talks << Talk.order('id DESC').limit(31).where('topic LIKE ? or topic LIKE  ?', '%嗎%', '%呢%').sample(1)
    # hour_groups = [1, 2, 4, 8]
    # hour_groups.each {|t| @talks << Talk.where(created_at: Time.now-t.hour-1.hour..Time.now-t.hour).order(id: :desc).sample(1)}
    #
    # day_groups = [1.day, 2.day, 4.day, 1.week]
    #  # , 2.week, 1.month, 3.month, 6.month, 1.year]
    # day_groups.each {|t| @talks << Talk.where(created_at: Time.now-t-1.day..Time.now-t).order(id: :desc).sample(3)}

    @shiritori_last = Talk.last[:topic].split('').last


    @all_talks = Talk.all

    respond_to do |format|
      format.html
      format.csv { send_data @all_talks.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  # GET /talks/new
  def new
    @parent_ids = []
    @talk = Talk.new
    session[:page] = 'new'
    @shiritori_last = Talk.find(params['f'])[:topic].split('').last
  end

  # GET /talks/1/edit
  # def edit
  # end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(talk_params)
    respond_to do |format|
      if create_new_talk(@talk)
        # shiritori(talk_params)
        format.html { redirect_to talks_path, notice: '⭕' }
        format.json { render :show, status: :created, location: @talk }
      else
        format.html { redirect_to talks_path, notice: '❌'  }
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
        params.require(:talk).permit(:topic, :from, :rate)
      elsif session[:page] == 'index'
        params.permit(:topic, :from, :rate)
      end
    end

    def create_new_talk(talk)
      if talk_params[:topic].include? "\n"
        talk_topics = talk_params[:topic].split("\n")
        talk_topics.each do |t|
          Talk.create(topic: t, from: talk[:from])
        end
      else
         talk.save
      end
    end

    def shiritori(talk)
      if talk[:from].present?
        talk[:topic].split('').first.upcase == Talk.find(talk[:from])[:topic].split('').last.upcase
      else
        talk[:topic].split('').first.upcase == Talk.last[:topic].split('').last.upcase
      end
    end
end
