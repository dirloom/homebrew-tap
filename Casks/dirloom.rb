cask "dirloom" do
  arch arm: "arm64", intel: "x86_64"

  version "0.3.0"

  on_macos do
    sha256 arm:   "79adc378b872aa579e132c50a2c02abff681dd382fcee732835eee87c9a774fe",
           intel: "ba6a592c88d05f2481386af2c8307e166e81b331174eb80289b1caccf7a29ffc"

    url "https://github.com/dirloom/dirloom/releases/download/v#{version}/dirloom_Darwin_#{arch}.tar.gz"
  end
  on_linux do
    sha256 arm:   "7d676fb380abb285502ce0ee79767e600d3ed7c6de4d238b118aa1f6db088ceb",
           intel: "254840b7462497613700dc7c1b7e0ecb2340031ce3e7660c683032a24aec0830"

    url "https://github.com/dirloom/dirloom/releases/download/v#{version}/dirloom_Linux_#{arch}.tar.gz"
  end

  name "Dirloom"
  desc "Clean project trees for humans and AI"
  homepage "https://github.com/dirloom/dirloom"

  livecheck do
    url "https://github.com/dirloom/dirloom/releases/latest"
    strategy :github_latest
  end

  binary "dirloom"

  postflight do
    executable = staged_path/"dirloom"
    prefix = Pathname.new(HOMEBREW_PREFIX)
    begin
      bash_dir = prefix/"etc/bash_completion.d"
      zsh_dir = prefix/"share/zsh/site-functions"
      fish_dir = prefix/"share/fish/vendor_completions.d"
      pwsh_dir = prefix/"share/pwsh/completions"
      bash_dir.mkpath
      zsh_dir.mkpath
      fish_dir.mkpath
      pwsh_dir.mkpath
      (bash_dir/"dirloom").write system_command(executable, args: ["completion", "bash"]).stdout
      (zsh_dir/"_dirloom").write system_command(executable, args: ["completion", "zsh"]).stdout
      (fish_dir/"dirloom.fish").write system_command(executable, args: ["completion", "fish"]).stdout
      (pwsh_dir/"dirloom.ps1").write system_command(executable, args: ["completion", "powershell"]).stdout
    rescue => e
      puts "Could not install generated shell completions (#{e.message}); run dirloom completion <shell> manually."
    end
  end

  caveats <<~EOS
    Generate shell completions from the installed binary if they were not
    installed automatically:

      dirloom completion bash
      dirloom completion zsh
      dirloom completion fish
      dirloom completion powershell
  EOS
end
