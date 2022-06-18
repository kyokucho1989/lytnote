class ReportsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reports = Report.where(user_id: current_user.id).page(params[:page])
    @genres_set = get_genre_nameset
  end

  def new
    @report = Report.new
    @report.report_items.build
    @select_genre = Genre.where(user_id: current_user)
  end

  def create
    binding.pry

#  ジャンル名登録
# ジャンル名がDBにあるかどうか
# あればそのジャンルidを返す
# なければ新規ジャンル作成
# そのジャンルidを返す




    para = report_genre_params[:report_items_attributes]

    report_lists = para.values
    report_lists.each do |report|
      genre_name = report[:genreset]
      if genre_name.nil?
        report[:genre_id] = nil
        break
      end
      @genre_new = Genre.find_by(name:genre_name,user_id: current_user)
      if @genre_new.nil?
        @genre_new = Genre.new("name"=> genre_name, "user_id" => current_user.id)
      end
      report[:genre_id] = @genre_new.id
    end

    binding.pry
    first_key = para.keys.first
    first_value = para.values.first
    para.reject! { |_key, value| value[:content] == "" }
    para[first_key] = first_value unless para.key?("content")

    para.values.map {|a| a.delete("genreset") }
    binding.pry
    formatted_para = report_params
    formatted_para[:report_items_attributes] = para
    genres_set = get_genre_nameset

    share_content = Report.convert_content_shared(formatted_para, genres_set)

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

  def get_genre_nameset
    genres = Genre.where(user_id: current_user.id)
    genres.pluck(:id, :name)
  end

  def show
    @report = Report.find(params[:id])
    @report_item_array = ReportItem.where(report_id: @report.id).to_a
    @genres = get_genre_nameset
  end

  def edit
    @report = Report.find(params[:id])
    @select_genre = Genre.where(user_id: current_user)
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy
    flash[:notice] = "日報を削除しました"
    redirect_to action: 'index'
  end

  def update
    @report = Report.find(params[:id])
    if !@report.update_attributes(report_params)
      flash.now[:alert] = "修正に失敗しました"
      @select_genre = Genre.where(user_id: current_user)
      render :edit
      return
    end

    genres_set = get_genre_nameset
    share_content = Report.convert_content_shared(report_params, genres_set)
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

  def get_genre_name(id)
    if id.nil?
      " "
    else
      genre = @genres.find{|array| array[:id] == id }
      genre.name 
    end   
  end

  helper_method :get_genre_name
  private

  def report_params
    params.require(:report).permit(:content, :reported_on, report_items_attributes: [:content, :genre_id, :work_hours, :content_for_share, :id])
  end

  def report_genre_params
    params.require(:report).permit(:content, :reported_on, report_items_attributes: [:content, :genre_id, :genreset, :work_hours, :content_for_share, :id])
  end
end
