class ReportsController < ApplicationController
  def index
    @reports = Report.where(user_id:current_user)
  end

  def new
    @report = Report.new
    3.times { @report.report_items.build }
  end

  def create
    para = report_params[:report_items_attributes]
    first_key = para.keys.first
    first_value = para.values.first
    para.reject!{|key,value| value[:content] == ""}
    if !para.key?("content") then
      para[first_key]=first_value
    end
    formatted_para = report_params
    formatted_para[:report_items_attributes] = para
    report = Report.new(formatted_para)
    report.user_id = current_user.id
    report.save!
  end

  def show
  end


  def edit
  end

  def destroy
  end

  def update
  end

  private
  def report_params
    params.require(:report).permit(:content,report_items_attributes:[:content,:genre_id,:work_hours])
    # params[:report][:report_items_attributes]
  end

end
