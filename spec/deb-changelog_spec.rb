require "deb-changelog"

RSpec.describe DebChangelog do
  it "parses the changelog line" do
    contents = "lazygit (0.23.6-1) xenial; urgency=medium"
    changelog = DebChangelog.parse(contents)
    expect(changelog).not_to eq nil
    expect(changelog.package).to eq "lazygit"
    expect(changelog.epoch).to eq nil
    expect(changelog.version).to eq "0.23.6"
    expect(changelog.revision).to eq "1"
    expect(changelog.distribution).to eq "xenial"
    expect(changelog.params).to eq "urgency=medium"
  end

  it "parses the full changelog entry " do
    contents = <<~EOCH
      lazygit (0.23.6-1) xenial; urgency=medium

        * gui: fix go-1.10 compatibility

       -- Dawid Dziurla <dawidd0811@gmail.com>  Wed, 14 Oct 2020 14:52:51 +0200
    EOCH
    changelog = DebChangelog.parse(contents)
    expect(changelog).not_to eq nil
    expect(changelog.package).to eq "lazygit"
    expect(changelog.epoch).to eq nil
    expect(changelog.version).to eq "0.23.6"
    expect(changelog.revision).to eq "1"
    expect(changelog.distribution).to eq "xenial"
    expect(changelog.params).to eq "urgency=medium"
    # TODO author and timestamp
  end
end
