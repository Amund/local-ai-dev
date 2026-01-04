import os
import json
import random
from pathlib import Path

# Langages que tu veux inclure
EXTENSIONS = {
    ".php", ".js", ".html", ".css", ".sql",
    ".json", ".yaml", ".yml", ".dockerfile", "Dockerfile"
}

# Taille min/max pour accepter un fichier
MIN_CHARS = 200
MAX_CHARS = 5000

# Ratio du middle à "masquer"
MIDDLE_RATIO = 0.2  # 20% du fichier

# Chemins
INPUT_DIR = "./my-projects"  # Ton dossier de projets
OUTPUT_FILE = "fim_dataset.jsonl"

def is_valid_code_file(file_path):
    ext = file_path.suffix.lower()
    if file_path.name.lower() == "dockerfile":
        return True
    return ext in EXTENSIONS

def extract_fim_sample(code: str):
    if not (MIN_CHARS < len(code) < MAX_CHARS):
        return None

    code = code.strip()
    total_len = len(code)
    middle_len = int(total_len * MIDDLE_RATIO)

    # Choisir un point de découpe aléatoire
    start = random.randint(int(total_len * 0.3), int(total_len * 0.7) - middle_len)
    end = start + middle_len

    prefix = code[:start]
    middle = code[start:end]
    suffix = code[end:]

    if not (prefix and middle and suffix):
        return None

    return {
        "prefix": prefix,
        "middle": middle,
        "suffix": suffix
    }

def main():
    output = []
    for root, dirs, files in os.walk(INPUT_DIR):
        for file_name in files:
            file_path = Path(root) / file_name
            if not is_valid_code_file(file_path):
                continue

            try:
                content = file_path.read_text(encoding="utf-8")
                sample = extract_fim_sample(content)
                if sample:
                    output.append(sample)
            except Exception as e:
                print(f"[WARN] Couldn't read {file_path}: {e}")

    print(f"✅ Extracted {len(output)} FIM samples.")

    with open(OUTPUT_FILE, "w", encoding="utf-8") as f_out:
        for sample in output:
            f_out.write(json.dumps(sample, ensure_ascii=False) + "\n")

    print(f"💾 Dataset saved to {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
