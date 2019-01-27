# frozen_string_literal: true

module Release
  module Notes
    module Configurable
      delegate :all_labels,
               :bug_title,
               :bugs,
               :feature_title,
               :features,
               :for_each_ref_format,
               :force_rewrite,
               :grep_insensitive?,
               :header_title,
               :header_title_type,
               :include_merges?,
               :link_commits?,
               :link_to_humanize,
               :link_to_labels,
               :link_to_sites,
               :log_all,
               :log_all_title,
               :misc,
               :misc_title,
               :output_file,
               :prettify_messages?,
               :regex_type,
               :release_notes_exist?,
               :single_label,
               :temp_file,
               :timezone,
               prefix: :config, to: :"Release::Notes.configuration"
    end
  end
end
