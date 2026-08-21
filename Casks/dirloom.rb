cask "dirloom" do
  arch arm: "arm64", intel: "x86_64"

  version "0.1.1"

  on_macos do
    sha256 arm:   "d8ce9d1704d33e776402000041c8a6cad8efa0ddb5b4adc01a3f45e90fce7544",
           intel: "828b634e36f88d0188f257e02e316ea090aca9f6ff74c2cc0bff5895a3df5d92"

    url "https://github.com/dirloom/dirloom/releases/download/v#{version}/dirloom_Darwin_#{arch}.tar.gz"
  end

  on_linux do
    sha256 arm:   "389f651db08503c0faa3907ba04bcd4bd7f9cc7c3eb5e098380178cb7f21c624",
           intel: "b4e55534fbbc86426873302fd691c5c182af17255e7d22e003e46f1a4ecb2612"

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

  generate_completions_from_executable "dirloom",
                                       shell_parameter_format: :cobra,
                                       shells:                 [:bash, :zsh, :fish, :pwsh]

  caveats <<~EOS
    Generate shell completions from the installed binary if they were not
    installed automatically:

      dirloom completion bash
      dirloom completion zsh
      dirloom completion fish
      dirloom completion powershell
  EOS
end
