class ReportsController < ApplicationController
  before_action :authenticate_user!
  def index
    @reports = Report.where(user_id: current_user.id).page(params[:page])
    @genres_set = get_genre_nameset
  end

  def new
    @report = Report.new
    3.times { @report.report_items.build }
    @select_genre = Genre.where(user_id: current_user)
  end

  def create
    para = report_params[:report_items_attributes]
    first_key = para.keys.first
    first_value = para.values.first
    para.reject! { |_key, value| value[:content] == "" }
    para[first_key] = first_value unless para.key?("content")
    formatted_para = report_params
    formatted_para[:report_items_attributes] = para
    report = Report.new(formatted_para)
    report.user_id = current_user.id
    report.save!
    genres_set = get_genre_nameset
    share_content = Report.convert_content_shared(formatted_para, genres_set)
  end

  def get_genre_nameset
    genres = Genre.where(user_id: current_user.id)
    genres.pluck(:id, :name)
  end
  helper_method :get_genre_nameset

  # def get_genre_name(id)
  #   @genres = Genre.where(user_id: current_user.id)
  #   @genres.where(id: id).first[:name]
  # end
  # helper_method :get_genre_name

  def show; end

  def edit
    @report = Report.find(params[:id])
    @select_genre = Genre.where(user_id: current_user)
  end

  def destroy
    report = Report.find(params[:id])
    report.destroy
  end

  def update
    report = Report.find(params[:id])
    report.update_attributes(report_params)
  end

  private

  def report_params
    params.require(:report).permit(:content, :reported_on, report_items_attributes: [:content, :genre_id, :work_hours, :id])
  end
end
