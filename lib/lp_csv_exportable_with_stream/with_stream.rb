module LpCSVExportable
  module WithStream
    attr_accessor :filename_prefix, :filename_suffix

    def self.included(base)
      base.extend ClassMethods
    end

    def to_csv_lazy(formatter)
      formatter.headers['Content-Type'] = 'text/csv; charset=utf-8'
      formatter.headers['Content-Disposition'] =
        "attachment; filename=\"#{filename_prefix}#{self.class.filename}#{filename_suffix}.csv\""
      formatter.headers['X-Accel-Buffering'] = 'no'
      formatter.headers['Cache-Control'] = 'no-cache'
      formatter.headers['Last-Modified'] = Time.zone.now.ctime.to_s
      formatter.headers.delete('Content-Length')
      formatter.response_body = Enumerator.new do |yielder|
        yielder << "\uFEFF" + CSV.generate_line(headers).to_s.force_encoding('UTF-8')
        collection.includes(self.class.collection_includes || []).each do |obj|
          yielder << CSV.generate_line(columns.map do |column|
            column.format(retrieve_value(obj, column))
          end).to_s.force_encoding('UTF-8')
        end
      end
    end

    module ClassMethods
      def filename=(name)
        @filename = name
      end

      def filename
        @filename
      end

      def collection_includes=(collection_includes)
        @collection_includes = collection_includes
      end

      def collection_includes
        @collection_includes
      end
    end
  end
end