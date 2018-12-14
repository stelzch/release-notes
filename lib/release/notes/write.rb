# frozen_string_literal: true

module Release
  module Notes
    class Write
      include Link
      include PrettyPrint

      delegate :output_file, :temp_file, :link_commits?, :all_labels,
               :prettify_messages?, :release_notes_exist?,
               :force_rewrite, to: :"Release::Notes.configuration"

      def initialize
        # create a new temp file regardless if it exists
        new_temp_file_template
      end

      # write strings to tempfile
      def digest(str)
        File.open(temp_file, "a") { |fi| fi << str }
      end

      # formats titles to be added to the new file
      # removes tags from title if configured
      def digest_title(title: nil, log_message: nil)
        @title = title
        @log_message = log_message

        titles = title_present + format_line
        digest(titles)
      end

      # formats the headers to be added to the new file
      def digest_header(header)
        @header = header
        digest(header_present)
      end

      # append old file to new temp file
      # overwrite output file with tmp file
      def write_new_file
        copy_over_notes if release_notes_exist? && !force_rewrite

        FileUtils.cp(temp_file, output_file)
        FileUtils.rm temp_file
      end

      private

      # @api private
      def header_present
        "\n## #{@header}\n"
      end

      # @api private
      def title_present
        "\n#{@title}\n\n"
      end

      # @api private
      def format_line
        return "#{prettify(line: link_messages)}\n" if prettify_messages?

        link_messages
      end

      # @api private
      def link_messages
        link_message @log_message
      end

      # @api private
      def copy_over_notes
        File.open(temp_file, "a") do |f|
          f << "\n"
          IO.readlines(output_file)[2..-1].each { |line| f << line }
        end
      end

      # @api private
      def link_message(log_message)
        return log_message unless link_commits?

        link_lines(lines: log_message)
      end

      # @api private
      def new_temp_file_template
        File.open(temp_file, "w") do |fi|
          fi << "# Release Notes\n"
        end
      end
    end
  end
end
