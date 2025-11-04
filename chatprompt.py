#!/usr/bin/env python3
from pathlib import Path
import sys
import re

def find_scripts(base_path: Path, class_names: list[str]) -> dict[str, list[Path]]:
    result = {cls: [] for cls in class_names}
    for script in base_path.rglob("*.gd"):
        try:
            text = script.read_text(encoding="utf-8")
        except Exception:
            continue
        for cls in class_names:
            pattern = rf"\bclass_name\s+{re.escape(cls)}\b"
            if re.search(pattern, text):
                result[cls].append((script, text))
    return result

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <base_path> <class1> <class2> ...")
        sys.exit(1)

    base = Path(".")
    classes = sys.argv[1:]
    found = find_scripts(base, classes)

    lines = ""
    for cls, paths in found.items():
        if paths:
            lines += f"```gd\n"
            lines += f"# res://{paths[0][0]}\n"
            lines += paths[0][1]
            lines += "```\n\n"

    with open("chatgpt.md", "w") as f:
        f.write(lines)
