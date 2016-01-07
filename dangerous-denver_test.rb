require 'minitest/autorun'
require 'minitest/emoji'
require_relative 'dangerous-denver'

class DangerousDenverTest < MiniTest::Test

  def test_address_analysis_for_traffic_accidents
    result = analyze_crime_data("./data/traffic-accidents.csv",
                                     :incident_address,
                                     nil)
    top_five_accident_intersections = [["I25 HWYNB / W 6TH AVE", 503],
                                       ["I25 HWYNB / W ALAMEDA AVE", 447],
                                       ["I25 HWYSB / 20TH ST", 398],
                                       ["I70 HWYEB / N HAVANA ST", 358],
                                       ["I25 HWYSB / W ALAMEDA AVE", 349]]
    assert_equal top_five_accident_intersections, result
  end

  def test_neighborhood_analysis_for_traffic_accidents
    result = analyze_crime_data("./data/traffic-accidents.csv",
                                     :neighborhood_id,
                                     nil)
    top_five_accident_neighborhoods = [["stapleton", 5597],
                                       ["capitol-hill", 3531],
                                       ["five-points", 3293],
                                       ["hampden-south", 3249],
                                       ["lincoln-park", 3242]]
    assert_equal top_five_accident_neighborhoods, result
  end

  def test_neighborhood_analysis_for_non_traffic_related_crimes
    result = analyze_crime_data("./data/crime.csv",
                                :neighborhood_id,
                                "traffic-accident")
    top_five_crime_neighborhoods = [["five-points", 13535],
                                    ["cbd", 11068],
                                    ["capitol-hill", 8809],
                                    ["montbello", 8445],
                                    ["stapleton", 7918]]
    assert_equal top_five_crime_neighborhoods, result
  end
end
