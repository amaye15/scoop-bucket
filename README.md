# Scoop bucket for dtk

[dtk](https://github.com/amaye15/dtk) is a Claude Code hook that turns big tables in command
output into short summaries. It works with [rtk](https://github.com/rtk-ai/rtk).

```powershell
scoop bucket add amaye15 https://github.com/amaye15/scoop-bucket
scoop install dtk
dtk init --global
dtk verify
```

The manifest follows the dtk releases by itself (`.github/workflows/update.yml`). To uninstall:
`dtk init --uninstall --purge`, then `scoop uninstall dtk`.
