module ActiveRecord
  module ConnectionAdapters 
    module SchemaStatements

      # Add a column and its index.
      # This just calls #add_column then #add_index

      def add_column_and_index(table_name, column_name, type, options = {})
        add_column(table_name, column_name, type, options)
        add_index(table_name, column_name, type, options)
      end


      # Remove a column and its index in one step.
      # This just calls #remove_column then #remove_index.

      def remove_column_and_index(table_name, column_name, type, options = {})
        remove_column(table_name, column_name, type, options)
        remove_index(table_name, column_name, type, options)
      end

    end
  end
end
