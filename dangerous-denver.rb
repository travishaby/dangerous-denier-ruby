require 'csv'
require 'pry'
require 'benchmark'

def analyze(file_path, analysis_attribute, optional_filter)
  data = parse_csv_data(file_path, optional_filter)
  analyze_crime_data(data, analysis_attribute)
end

def parse_csv_data(file_path, optional_filter)
  data = []
  CSV.foreach(file_path, headers: true, header_converters: :symbol) do |row|
    data << row.to_h
  end

  if optional_filter
    data = data.reject do |incident|
      incident[:offense_category_id] == optional_filter
    end
  end
  data
end

def analyze_crime_data(data, analysis_attribute)
  grouped = data.group_by do |incident|
    incident[analysis_attribute]
  end
  grouped.shift #remove nil key from hash

  counted = grouped.map do |key, incidents|
    [key, incidents.count]
  end
  .sort_by do |incident_count|
    -incident_count[1] #sort by count of incidents
  end[0..4]
end

if __FILE__ == $0
  Benchmark.bm do |task|
    task.report { result = analyze("./data/traffic-accidents.csv",
                                     :incident_address,
                                     nil)
                 puts result
                }
  end
  Benchmark.bm do |task|
   task.report { result = analyze("./data/traffic-accidents.csv",
                                    :incident_address,
                                    nil)
                puts result
               }
  end
  Benchmark.bm do |task|
    task.report { result = analyze("./data/crime.csv",
                                     :neighborhood_id,
                                     "traffic-accident")
                 puts result
                }
  end
end
