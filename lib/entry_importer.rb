require 'csvscan'

module EntryImporter
  class << self

    def import data
  
      count = 0
      fields = []
      
      # read uploaded file
      file_data = data[:file]
      if file_data.respond_to?(:read)
        file_contents = file_data.read
      elsif file_data.respond_to?(:path)
        file_contents = File.read(file_data.path)
      else
        return false
      end

      # loop through the csv entries
      entry_field = {}
      name_field_index, slug_field_index, published_at_field_index, unpublished_at_field_index, user_field_index = nil
      CSVScan.scan(file_contents) do |row|
        # get fields from first row
        if count == 0
          fields = row
          row.each_with_index do |field, index|
            name_field_index = index if field == data[:name_field]
            slug_field_index = index if field == data[:slug_field]
            published_at_field_index = index if field == data[:name_field]
            unpublished_at_field_index = index if field == data[:unpublished_at_field]
            user_field_index = index if field == data[:user_field]
          end
        else
          # combine fields and values
          entry_data_values = {}      
          row.each_with_index do |value, index|
            entry_field[:name] = value if index == name_field_index
            entry_field[:slug] = value if index == slug_field_index
            entry_field[:published_at] = value if index == published_at_field_index
            entry_field[:unpublished_at] = value if index == unpublished_at_field_index
            entry_field[:user] = value if index == user_field_index
            
            entry_data_values[fields[index].to_sym] = value
          end
          
          # set additional entry properties
          entry_field[:data_model_id] = data[:data_model_id]
          entry_field[:data_values] = entry_data_values
          entry_field[:host] = Host.default
          ####entry_field[:user] = current_user.id if entry_field[:user].nil?
          
          # make new entry
          entry = DataEntry.new(entry_field)
          puts entry.inspect
          entry.save
        end
        count = count + 1
      end
  
      
      puts "Entry Importer: #{count} rows processed."   
      return count
    end
  
  end
end