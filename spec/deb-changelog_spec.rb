require "deb-changelog"

RSpec.describe DebChangelog do
  describe ".parse" do
    it "parses one changelog entry" do
      contents = <<~EOCH
        lazygit (0.23.6-1) xenial; urgency=medium

          * gui: fix go-1.10 compatibility

         -- Dawid Dziurla <dawidd0811@gmail.com>  Wed, 14 Oct 2020 14:52:51 +0200
      EOCH

      changelog = DebChangelog.parse contents

      p changelog
      expect(changelog).not_to eq nil

      expect(changelog.last["package"]).to eq "lazygit"
      expect(changelog.last["epoch"]).to eq nil
      expect(changelog.last["version"]).to eq "0.23.6"
      expect(changelog.last["revision"]).to eq "1"
      expect(changelog.last["distribution"]).to eq "xenial"
      expect(changelog.last["params"]).to eq "urgency=medium"
      expect(changelog.last["changes"]).to eq ["gui: fix go-1.10 compatibility"]
      expect(changelog.last["author_name"]).to eq "Dawid Dziurla"
      expect(changelog.last["author_email"]).to eq "dawidd0811@gmail.com"
      expect(changelog.last["timestamp"]).to eq "Wed, 14 Oct 2020 14:52:51 +0200"
    end

    it "parses multiple changelog entries" do
      contents = <<~EOCH
        lazygit (0.23.6-1) xenial; urgency=medium

          * gui: fix go-1.10 compatibility

         -- Dawid Dziurla <dawidd0811@gmail.com>  Wed, 14 Oct 2020 14:52:51 +0200

        lazygit (0.23.5-1) xenial; urgency=medium

          * more password checks on commands that talk to the remote

          [ nullawhale ]
          * Copy a commit message to clipboard: Changes to latest version

          * preserve width of side panel when main view split unless window is wide enough
          * support rebinding confirm/newline keys in editor

          [ Dawid Dziurla ]
          * workflows: update PPA repo as part of CD process
          * utils: ReplaceAll -> Replace
          * workflows: run CD on Ubuntu 20.04
          * workflows: don't sign commit

         --  <runner@fv-az193.3pvolxcpcztu3ic5y2mhkwl54d.bx.internal.cloudapp.net>  Tue, 13 Oct 2020 22:07:59 +0000
      EOCH

      changelog = DebChangelog.parse contents

      expect(changelog).not_to eq nil

      expect(changelog.first["package"]).to eq "lazygit"
      expect(changelog.first["epoch"]).to eq nil
      expect(changelog.first["version"]).to eq "0.23.6"
      expect(changelog.first["revision"]).to eq "1"
      expect(changelog.first["distribution"]).to eq "xenial"
      expect(changelog.first["params"]).to eq "urgency=medium"
      expect(changelog.first["changes"]).to eq ["gui: fix go-1.10 compatibility"]
      expect(changelog.first["author_name"]).to eq "Dawid Dziurla"
      expect(changelog.first["author_email"]).to eq "dawidd0811@gmail.com"
      expect(changelog.first["timestamp"]).to eq "Wed, 14 Oct 2020 14:52:51 +0200"

      expect(changelog.last["package"]).to eq "lazygit"
      expect(changelog.last["epoch"]).to eq nil
      expect(changelog.last["version"]).to eq "0.23.5"
      expect(changelog.last["revision"]).to eq "1"
      expect(changelog.last["distribution"]).to eq "xenial"
      expect(changelog.last["params"]).to eq "urgency=medium"
      expect(changelog.last["changes"].length).to eq 8
      expect(changelog.last["author_name"]).to eq ""
      expect(changelog.last["author_email"]).to eq "runner@fv-az193.3pvolxcpcztu3ic5y2mhkwl54d.bx.internal.cloudapp.net"
      expect(changelog.last["timestamp"]).to eq "Tue, 13 Oct 2020 22:07:59 +0000"
    end
  end
end
