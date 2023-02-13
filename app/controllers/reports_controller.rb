class ReportsController < ApplicationController
  before_action :authenticate_user!
  include Component
  
  def index
    @reports= Report.includes(:report_items).where(user_id: current_user.id).page(params[:page]).order(reported_on: :desc)
    @genres_set = get_genre_nameset
    reported_days_original = @reports.map(&:reported_on)
    reported_days = reported_days_original.map{
      |days| days.strftime("%F")
    }
    @reported_days = reported_days.to_json
  end

  def new
    @report = Report.new
    @report.report_items.build
    @select_genre = Genre.where(user_id: current_user)
  end

  def filter_report
    @para = params
    binding.pry
    respond_to do |format| # リクエスト形式によって処理を切り分ける
      format.html { redirect_to :root } # html形式の場合
      format.json { render json: @messages } # json形式の場合
    end
  end

  def create
    para = report_genre_params[:report_items_attributes]

    report_lists = para.values
    report_lists.each do |report|
      genre_name = report[:genre_name]
      if genre_name.nil?
        report[:genre_id] = nil
        break
      end
      @genre_new = Genre.find_by(name:genre_name,user_id: current_user)
      if @genre_new.nil?
        @genre_new = Genre.new("name"=> genre_name, "user_id" => current_user.id)
        @genre_new.save
      end
      report[:genre_id] = @genre_new.id
    end

    first_key = para.keys.first
    first_value = para.values.first
    para.reject! { |_key, value| value[:content] == "" }
    para[first_key] = first_value unless para.key?("content")

    para.values.map {|a| a.delete("genreset") }
    formatted_para = report_params
    formatted_para[:report_items_attributes] = para
    genres_set = get_genre_nameset

    share_content = Report.convert_content_shared(formatted_para, genres_set)
    formatted_para[:report_items_attributes].values.map{
      |a| a.delete("genre_name")
    }
    @report = Report.new(formatted_para)
    @report.user_id = current_user.id
    @report.content_for_share = share_content
    if @report.save
      flash[:notice] = "日報を投稿しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "投稿に失敗しました"
      @select_genre = Genre.where(user_id: current_user)
      render :new
    end
  end

  def get_genre_id(genre_name)
    genre = Genre.find_by(name:genre_name,user_id: current_user)
    if genre.nil?
      genre = Genre.new("name"=> genre_name, "user_id" => current_user.id)
      genre.save
    end
    genre.id
  end

  # def get_genre_nameset
  #   genres = Genre.where(user_id: current_user.id)
  #   genres.pluck(:id, :name)
  # end

  def show
    @report = Report.find(params[:id])
    @report_item_array = ReportItem.where(report_id: @report.id).to_a
    @genres = get_genre_nameset
    @select_genre = Genre.where(user_id: current_user)
  end

  def edit
    @report = Report.find(params[:id])
    @select_genre = Genre.where(user_id: current_user)
    @genres = @select_genre
    # binding.pry/
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy
    flash[:notice] = "日報を削除しました"
    redirect_to action: 'index'
  end

  def update
    update_params = report_genre_params
    update_params[:report_items_attributes].values.each do |report|
      genre_name = report[:genre_name]
      report[:genre_id] = get_genre_id(genre_name)
      report.delete("genre_name")
    end
    @report = Report.find(params[:id])
    if !@report.update_attributes(update_params)
      flash.now[:alert] = "修正に失敗しました"
      @select_genre = Genre.where(user_id: current_user)
      render :edit
      return
    end

    genres_set = get_genre_nameset
    share_content = Report.convert_content_shared(update_params, genres_set)
    @report.update_attributes(content_for_share: share_content)

    if @report.update_attributes(content_for_share: share_content)
      flash[:notice] = "日報を修正しました"
      redirect_to action: 'index'
    else
      flash.now[:alert] = "修正に失敗しました"
      @select_genre = Genre.where(user_id: current_user)
      render :edit
    end
  end

  helper_method :get_genre_name
  private

  def report_params
    params.require(:report).permit(:content, :reported_on, report_items_attributes: [:content, :genre_id, :work_hours, :content_for_share, :id])
  end

  def report_genre_params
    params.require(:report).permit(:content, :reported_on, report_items_attributes: [:content, :genre_id, :genreset, :genre_name ,:work_hours, :content_for_share, :id])
  end
end
