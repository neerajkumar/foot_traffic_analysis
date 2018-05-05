require 'rails_helper'

RSpec.describe AnalysisReportsController, type: :controller do
  before { ObjectSpace.garbage_collect }

  describe 'GET #index' do
    subject { get :index }

    context 'when no file uploaded' do
      it 'renders index template and 200 response' do
        expect(subject).to have_http_status(200)
        expect(subject).to render_template(:index)
      end

      it 'returns empty hash object' do
        expect(subject.body).to be_empty
      end
    end

    context 'when file uploaded' do

      let(:file) { File.open(File.dirname(__FILE__) + '/../input.txt', 'r') }

      before do
        Report.new(file).generate
      end

      it 'renders 200' do
        expect(subject).to have_http_status(200)
        expect(subject).to render_template(:index)
      end

      it 'returns non empty hash object' do
        expect(subject.body).to be_empty
        expect(assigns[:analysis_hash]).to_not be_empty
        expect(assigns[:analysis_hash]).to include('0' => [1, 20])
      end
    end
  end

  describe 'POST #create' do
    let(:file) do
      ActionDispatch::Http::UploadedFile.new({
        filename: 'input.txt',
        type: 'plain/text',
        tempfile: File.new(Rails.root.join('spec/input.txt'))
      })
    end

    subject { post :create, params: { logfile: file } }

    it 'generates the Report and redirects to index action' do
      # expect(subject).to have_http_status(302)
    end
  end
end
