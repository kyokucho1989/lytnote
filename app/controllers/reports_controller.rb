class ReportsController < ApplicationController
  def index
    @reports = Report.where(user_id:current_user)
  end

  def new
    @report = Report.new
    @report.report_items.build
  end

  def create
    report = Report.new(report_params)
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
  end

end
