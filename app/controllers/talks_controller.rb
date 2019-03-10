class TalksController < ApplicationController
  before_action :set_talk, only: [:show, :edit, :update, :destroy]

  def mic
    (session[:mic] == 'on') ? session[:mic] = 'off' : session[:mic] = 'on'
    redirect_to talks_path
  end

  def lang
    (session[:lang] == 'en') ? session[:lang] = 'zh-TW' : session[:lang] = 'en'
    redirect_to talks_path
  end

  # GET /talks
  # GET /talks.json

  def goto
  end

  def index
    if params[:you_want] =~ /真的假的|貞的假的/
      redirect_to 'https://cofacts.g0v.tw/replies?before=&after=&q=' + params[:you_want][0..-5]
    elsif params[:you_want] =~ /打給/
      redirect_to 'tel:+' + params[:you_want][2..-1]
    elsif params[:you_want] =~ /簡訊給/
      redirect_to 'sms:' + params[:you_want].split('簡訊給')[1] + '&body=' + params[:you_want].split('簡訊給')[0]
    elsif params[:you_want] =~ /候選人/
      redirect_to 'https://councils.g0v.tw/?name=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的台語|的臺語|地台語|地臺語/
      redirect_to 'https://itaigi.tw/k/' + params[:you_want][0..-4]
    # elsif params[:you_want] =~ /的阿美語|地阿美語/
    #   redirect_to 'https://amis.moedict.tw/' + params[:you_want][0..-5]
    elsif params[:you_want] =~ /的政治獻金|地政治獻金/
      redirect_to 'https://www.readr.tw/project/political-contribution/explore?name=' + params[:you_want][0..2] + "&ordinal=9"  
    elsif params[:you_want] =~ /在哪/
      redirect_to 'https://www.google.com/maps/search/' + params[:you_want][0..-3]
    elsif params[:you_want] =~ /外送|外賣/
      redirect_to 'https://www.ubereats.com/zh-TW/search/?q=' + params[:you_want][0..-3]
    elsif params[:you_want] =~ /的英文|地英語/
      redirect_to 'https://translate.google.com.tw/#view=home&op=translate&sl=auto&tl=en&text=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的文件|地文件/
      redirect_to 'https://drive.google.com/drive/u/0/search?q=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的活動|地活動/
      redirect_to 'https://calendar.google.com/calendar/r/search?q=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /^(記得|記住)/
      redirect_to 'https://calendar.google.com/calendar/event?action=TEMPLATE&text=' + params[:you_want][2..-1]
    elsif params[:you_want] =~ /的圖片|地圖片/
      redirect_to 'https://www.google.com.tw/search?tbm=isch&q=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的動圖/
      redirect_to 'https://giphy.com/search/' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的文獻|地文獻/
      redirect_to 'https://scholar.google.com.tw/scholar?q=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的民宿|地民宿/
      redirect_to 'https://www.airbnb.com.tw/s/homes?query=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的文章|地文章/
      redirect_to 'https://medium.com/search?q=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的程式碼|地程式碼|的城市碼|地城市碼/
      redirect_to 'https://github.com/search?q=' + params[:you_want][0..-5]
    elsif params[:you_want] =~ /的資料|地資料/
      redirect_to 'https://www.wikidata.org/w/index.php?search=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的用藥|地用藥/
      redirect_to 'http://g0v.github.io/agriculture/pesticide/usages/?q=' + params[:you_want][0..-4]
    elsif params[:you_want] =~ /的公民科技新聞|地公民科技新聞/
      redirect_to 'https://g0v.news/search?q=' + params[:you_want][0..-8]
    elsif params[:you_want] =~ /自拍的相片/
      redirect_to 'https://photos.google.com/search/selfies'
    elsif params[:you_want]
      redirect_to goto_talks_path(you_want: params[:you_want])
    end

    session[:page] = 'index'
    @talks=[]
    # @parent_ids = []
    @talks << Talk.order(id: :desc).first(1)
    # @talks << Talk.order('id DESC').limit(31).where('topic LIKE ? or topic LIKE  ?', '%嗎%', '%呢%').sample(1)
    # hour_groups = [1, 2, 4, 8]
    # hour_groups.each {|t| @talks << Talk.where(created_at: Time.now-t.hour-1.hour..Time.now-t.hour).order(id: :desc).sample(1)}
    #
    # day_groups = [1.day, 2.day, 4.day, 1.week]
    #  # , 2.week, 1.month, 3.month, 6.month, 1.year]
    # day_groups.each {|t| @talks << Talk.where(created_at: Time.now-t-1.day..Time.now-t).order(id: :desc).sample(3)}

    # @shiritori_last = Talk.last[:topic].split('').last


    # @all_talks = Talk.all

    respond_to do |format|
      format.html
      #format.csv { send_data @all_talks.to_csv, filename: "users-#{Date.today}.csv" }
    end
  end

  # GET /talks/1
  # GET /talks/1.json
  def show
  end

  # GET /talks/new
  # def new
  #   # @parent_ids = []
  #   @talk = Talk.new
  #   session[:page] = 'new'
  #   # @shiritori_last = Talk.find(params['f'])[:topic].split('').last
  # end

  # GET /talks/1/edit
  # def edit
  # end

  # POST /talks
  # POST /talks.json
  def create
    @talk = Talk.new(talk_params)
    respond_to do |format|
      format.html { redirect_to talks_path(you_want: @talk.topic) }

      # if @talk.save
      #   # create_new_talk(@talk)
      #   # shiritori(talk_params)
      #   # format.html { redirect_to "https://www.google.com/search?q=#{@talk.topic}&btnI=" }
      #   format.html { redirect_to talks_path, notice: '⭕', you_want: @talk.topic }
      #   # format.json { render :show, status: :created, location: @talk }
      # else
      #   format.html { redirect_to talks_path, notice: '❌'  }
      #   format.json { render json: @talk.errors, status: :unprocessable_entity }
      # end
    end
  end

  # def add
  #   Talk.create(topic: params[:t])
  #   redirect_to talks_path
  # end

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
