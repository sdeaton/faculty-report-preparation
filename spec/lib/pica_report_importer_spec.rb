class TempFileMocker
  def tempfile
    File.new(Rails.root.join('spec', 'test_files', 'StatisticsReport.xlsx'))
  end
end

RSpec.describe PicaReportImporter do

  let(:mock_file) { TempFileMocker.new }

  describe "#evaluation_hashes" do
    it "doesn't have nil attributes anywhere" do
      hashes = PicaReportImporter.new(mock_file).evaluation_hashes
      hashes.each do |hash|
        hash.each do |k, v|
          expect(v).not_to be(nil)
        end
      end
    end
  end
end
