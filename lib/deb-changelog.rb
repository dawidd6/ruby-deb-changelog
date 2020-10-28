class DebChangelog
  FIRST_LINE_REGEX = /^(?<package>.+) \(((?<epoch>[0-9]+):)?(?<version>[^:-]+)(-(?<revision>[^:-]+))?\) (?<distribution>.+); (?<params>.+)$/.freeze
  LIST_LINE_REGEX = /^ -- (?<author_name>.+) <(?<author_email>.+@.+\..+)> (?<timestamp>.+)$/.freeze

  attr_reader :package, :epoch, :version, :revision, :distribution, :params

  def initialize(captures)
    @package = captures["package"]
    @epoch = captures["epoch"]
    @version = captures["version"]
    @revision = captures["revision"]
    @distribution = captures["distribution"]
    @params = captures["params"]
  end

  def self.parse_file(file)
    contents = File.read(file)
    parse(contents)
  end

  def self.parse(contents)
    captures = contents.match(FIRST_LINE_REGEX).named_captures
    new(captures)
  end
end
