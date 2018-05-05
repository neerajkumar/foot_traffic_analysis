class AnalysisReportsController < ApplicationController

  def index
    report = ObjectSpace.each_object(Report).first
    @analysis_hash = report.present? ? report.report_hash : {}
  end

  def create
    if params[:logfile].present? && params[:logfile].tempfile.present?
      if !['.log', '.txt'].include?(File.extname(params[:logfile].tempfile))
        redirect_to analysis_reports_path, alert: 'Unsupportive Format. Supported format - .log or .txt'
      else
        Report.new(params[:logfile].tempfile).generate
        redirect_to analysis_reports_path, notice: 'Report successfully generated'
      end
    end
  end

end
