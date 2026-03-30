# Quick Agent — Demo
# Run: vhs demo.tape

Output assets/demo.gif

Require quick-agent

Set Shell "zsh"
Set FontFamily "JetBrains Mono"
Set FontSize 15
Set Width 1000
Set Height 650
Set Padding 20
Set Theme "Catppuccin Mocha"
Set TypingSpeed 40ms
Set Framerate 30
Set WindowBar Colorful
Set Margin 20
Set MarginFill "#1e1e2e"
Set BorderRadius 10

# Start clean
Hide
Type "clear"
Enter
Sleep 500ms
Show

# Show help
Type "quick-agent --help"
Sleep 500ms
Enter
Sleep 2s

# Run install
Type "quick-agent install"
Sleep 500ms
Enter
Sleep 4s

# Accept defaults
Type "y"
Enter
Sleep 3s

# Show status
Type "quick-agent status"
Sleep 500ms
Enter
Sleep 3s

# Done
Sleep 2s
