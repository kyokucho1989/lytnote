class ReportItemsController < ApplicationController
  def destroy
    report_item = ReportItem.find(params[:id])
    report_item.destroy
  end
end
