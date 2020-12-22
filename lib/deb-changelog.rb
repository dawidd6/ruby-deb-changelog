class DebChangelog
  METADATA_REGEX = /^(?<package>.+) \(((?<epoch>[0-9]+):)?(?<version>[^:-]+)(-(?<revision>[^:-]+))?\) (?<distribution>.+); (?<params>.+)$/.freeze
  CHANGE_REGEX = /^  \* (?<message>.+)$/.freeze
  AUTHOR_REGEX = /^ -- (?<author_name>.*) <(?<author_email>.+@.+\..+)>  (?<timestamp>.+)$/.freeze

  def self.parse_file(file)
    contents = File.read file
    parse contents
  end

  def self.parse(contents)
    entries = []

    contents.each_line do |line|
      line.chomp!

      if (metadata = line.match(METADATA_REGEX)&.named_captures)
        entries << metadata
        next
      end

      if (change = line.match(CHANGE_REGEX)&.named_captures)
        entries.last["changes"] ||= []
        entries.last["changes"] << change["message"]
        next
      end

      if (author = line.match(AUTHOR_REGEX)&.named_captures)
        entries.last.merge! author
        next
      end
    end

    entries
  end
end
