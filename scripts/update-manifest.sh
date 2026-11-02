#!/bin/bash
# Writes bucket/dtk.json for a release of amaye15/dtk (default: the newest). Needs the gh CLI.
# Public release data only, so the default workflow token is enough.
set -euo pipefail
repo="amaye15/dtk"
tag="${1:-$(gh release view -R "$repo" --json tagName -q .tagName)}"
ver="${tag#v}"
asset="dtk-$tag-x86_64-pc-windows-msvc.zip"
sum="$(gh release download "$tag" -R "$repo" -p "$asset.sha256" -O - | awk '{print tolower($1)}')"

cat > "$(dirname "$0")/../bucket/dtk.json" <<JSON
{
    "version": "$ver",
    "description": "Data token killer: a Claude Code hook that turns big tables into lean summaries. Works with rtk.",
    "homepage": "https://github.com/$repo",
    "license": "MIT",
    "architecture": {
        "64bit": {
            "url": "https://github.com/$repo/releases/download/$tag/$asset",
            "hash": "$sum"
        }
    },
    "bin": "dtk.exe",
    "notes": [
        "Get started:",
        "  dtk init --global     # register the Claude Code hook (works with rtk)",
        "  dtk verify            # check that everything works",
        "Uninstall: dtk init --uninstall --purge, then scoop uninstall dtk"
    ],
    "checkver": "github",
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://github.com/$repo/releases/download/v\$version/dtk-v\$version-x86_64-pc-windows-msvc.zip",
                "hash": {
                    "url": "\$url.sha256"
                }
            }
        }
    }
}
JSON
python3 -I -c 'import json,sys; json.load(open(sys.argv[1]))' "$(dirname "$0")/../bucket/dtk.json"
echo "wrote bucket/dtk.json for $tag"
