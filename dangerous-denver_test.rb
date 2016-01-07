require 'minitest/autorun'
require 'minitest/emoji'
require_relative 'dangerous-denver'

class DangerousDenverTest < MiniTest::Test

  def test_address_analysis_for_traffic_accidents
    result = analyze_crime_data("./data/traffic-accidents.csv",
                                     :incident_address,
                                     nil)
    top_five_accident_areas = [["I25 HWYNB / W 6TH AVE", 503],
                               ["I25 HWYNB / W ALAMEDA AVE", 447],
                               ["I25 HWYSB / 20TH ST", 398],
                               ["I70 HWYEB / N HAVANA ST", 358],
                               ["I25 HWYSB / W ALAMEDA AVE", 349]]
    assert_equal top_five_accident_areas, result
  end

end
