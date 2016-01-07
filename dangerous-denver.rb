require 'csv'
require 'pry'
require 'benchmark'

def analyze_crime_data(file_path, analysis_attribute, optional_filter)
  data = []
  CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
    data << row.to_h
  end

  if optional_filter
    data = data.reject do |incident|
      incident[:offense_category_id] == optional_filter
    end
  end

  grouped = data.group_by do |incident|
    incident[analysis_attribute]
  end
  grouped.shift #remove nil key from hash

  counted = grouped.map do |key, incidents|
    [key, incidents.count]
  end

  analysis = counted.sort_by do |incident_count|
    -incident_count[1] #sort by count of incidents
  end

  puts analysis[0..4]
end

Benchmark.bm do |task|
  task.report { analyze_crime_data("./data/traffic-accidents.csv",
                                   :incident_address,
                                   nil) }
end
Benchmark.bm do |task|
 task.report { analyze_crime_data("./data/traffic-accidents.csv",
                                  :incident_address,
                                  nil) }
end
Benchmark.bm do |task|
  task.report { analyze_crime_data("./data/crime.csv",
                                   :neighborhood_id,
                                   "traffic-accident") }
end
