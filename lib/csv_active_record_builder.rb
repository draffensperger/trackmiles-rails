module CSVActiveRecordBuilder
  extend self

  def self.build_from_rows(class_name, rows)
    fields = rows.shift
    rows.map do |row|
      attrs = {}
      fields.each_with_index do |field, i|
        attrs[field] = row[i]
      end
      class_name.constantize.new attrs
    end
  end

  def self.build(class_name, csv_file)
    build_from_rows class_name, CSV.read(csv_file)
  end
end