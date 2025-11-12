#!/usr/bin/env python3
from pathlib import Path

ROOT = Path(__file__).parent
OUTPUT = ROOT / "all_scripts.md"

def main():
    exts = { ".gd" } #, ".tscn")
    total_tokens = 0
    files = []

    for path in ROOT.rglob("*"):
        if any(part.startswith(".") for part in path.parts):
            continue  # Skip .git and other hidden dirs/files
        if path.suffix in exts:
            files.append(path)

    files.sort()

    with OUTPUT.open("w", encoding="utf-8") as md:
        readme_content = Path("./README.md").read_text(encoding="utf-8", errors="ignore")
        total_tokens += len(readme_content)
        md.write(readme_content)
        md.write("\n")

        for file_path in files:
            rel_path = file_path.relative_to(ROOT)
            content = file_path.read_text(encoding="utf-8", errors="ignore")
            total_tokens += len(content)

            md.write(f"# res://{rel_path.as_posix()}\n")
            md.write(f"```{file_path.suffix[1:]}\n")
            md.write(content)
            md.write("\n```\n\n")

    total_tokens = total_tokens // 4
    print(f"Wrote {len(files)} files to {OUTPUT}")
    print(f"Estimated total tokens: {total_tokens:,}")

if __name__ == "__main__":
    main()
