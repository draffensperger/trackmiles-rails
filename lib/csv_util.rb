module CSVUtil
  extend self

  def self.hashes_from_rows(rows)
    fields = rows.shift.map {|c| c.to_sym}
    rows.map do |row|
      attrs = {}
      fields.each_with_index do |field, i|
        attrs[field] = row[i]
      end
      attrs
    end
  end

  def self.load_as_hashes(csv_file)
    hashes_from_rows CSV.read(csv_file)
  end
end