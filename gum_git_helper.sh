#!/bin/bash

# Periksa apakah 'gum' sudah terinstal
if ! command -v gum &> /dev/null; then
    echo "Error: 'gum' tidak ditemukan."
    echo "Silakan instal terlebih dahulu dari https://github.com/charmbracelet/gum"
    exit 1
fi

# --- Konfigurasi Menu ---
# Anda bisa mengubah atau menambahkan opsi di sini
TYPE_OPTIONS=("feat" "fix" "docs" "style" "refactor" "test" "chore" "ci" "build" "[ ketik manual ]")
SCOPE_OPTIONS=("api" "ui" "db" "auth" "ci" "docs" "[ ketik manual ]")

# --- Fungsi Bantuan ---
style_header() {
    gum style --border normal --padding "1" --border-foreground 212 "$1"
}

# Fungsi untuk menampilkan pratinjau pesan commit secara bertahap
show_preview() {
    local type=$1
    local scope=$2
    local subject=$3
    local header=""

    if [ -z "$type" ]; then
        return
    fi

    header="$type"
    if [ -n "$scope" ]; then
        header="$header($scope)"
    fi
    header="$header: $subject"
    
    echo "👀 Pratinjau Pesan Commit:"
    gum style --padding "1" --border-foreground 240 "$header"
}


# ==============================================================================
#                                  PROGRAM UTAMA
# ==============================================================================

# --- Langkah 1: Memilih File untuk di-Commit (git add) ---
style_header "Langkah 1: Pilih File untuk di-Commit"
UNSTAGED_FILES=$(git status --porcelain | awk '{print $2}')

if [ -z "$UNSTAGED_FILES" ]; then
    gum style --foreground "yellow" "Tidak ada file yang berubah untuk di-commit."
    exit 0
fi

gum_choice=$(gum choose "✨ Tambah semua file yang berubah" "🤔 Pilih file satu per satu")

if [[ "$gum_choice" == "✨ Tambah semua file yang berubah" ]]; then
    git add .
    echo "Semua file yang berubah telah ditambahkan."
else
    SELECTED_FILES=$(echo "$UNSTAGED_FILES" | gum choose --no-limit --header "Pilih file (spasi untuk memilih, enter untuk lanjut)")
    if [ -z "$SELECTED_FILES" ]; then echo "Tidak ada file yang dipilih. Dibatalkan."; exit 1; fi
    echo "$SELECTED_FILES" | tr ' ' '\n' | xargs git add
    echo "File terpilih telah ditambahkan."
fi

# --- Langkah 2: Membuat Pesan Commit (Interaktif dengan Pratinjau) ---
style_header "Langkah 2: Buat Pesan Commit"

COMMIT_TYPE=""
COMMIT_SCOPE=""
COMMIT_SUBJECT=""
COMMIT_BODY=""

# --- Memilih Tipe Commit ---
gum log --structured --level info "Pilih tipe commit..."
COMMIT_TYPE_CHOICE=$(printf "%s\n" "${TYPE_OPTIONS[@]}" | gum choose)
if [[ "$COMMIT_TYPE_CHOICE" == "[ ketik manual ]" ]]; then
    COMMIT_TYPE=$(gum input --placeholder "Ketik tipe commit kustom...")
else
    COMMIT_TYPE=$COMMIT_TYPE_CHOICE
fi
show_preview "$COMMIT_TYPE"

# --- Memilih Scope Commit ---
gum log --structured --level info "Pilih scope commit (opsional)..."
COMMIT_SCOPE_CHOICE=$(printf "%s\n" "${SCOPE_OPTIONS[@]}" | gum choose --header "Pilih scope atau ketik manual")
if [[ "$COMMIT_SCOPE_CHOICE" == "[ ketik manual ]" ]]; then
    COMMIT_SCOPE=$(gum input --placeholder "Ketik scope kustom (enter untuk lewati)")
else
    COMMIT_SCOPE=$COMMIT_SCOPE_CHOICE
fi
show_preview "$COMMIT_TYPE" "$COMMIT_SCOPE"

# --- Menulis Subjek Commit ---
gum log --structured --level info "Tulis subjek commit..."
COMMIT_SUBJECT=$(gum input --placeholder "Tulis subjek yang singkat dan jelas")
if [ -z "$COMMIT_SUBJECT" ]; then echo "Subjek tidak boleh kosong. Dibatalkan."; exit 1; fi
show_preview "$COMMIT_TYPE" "$COMMIT_SCOPE" "$COMMIT_SUBJECT"

# --- Merakit Pesan Final ---
FULL_MESSAGE="$COMMIT_TYPE($COMMIT_SCOPE): $COMMIT_SUBJECT"

# --- Langkah 3: Konfirmasi dan Push ---
style_header "Langkah 3: Konfirmasi & Push"
BRANCH=$(git branch --show-current)

echo -e "Anda akan melakukan push ke branch: $(gum style --bold --foreground '#00AFFF' $BRANCH)"
echo "Dengan pesan commit final:"
gum style --padding "1 2" --border thick --border-foreground 212 "$FULL_MESSAGE"

if ! gum confirm "Lanjutkan proses commit dan push?"; then
    echo "Proses dibatalkan oleh pengguna."
    exit 1
fi

gum spin --spinner line --title "Melakukan commit..." -- git commit -m "$FULL_MESSAGE"
gum spin --spinner line --title "Pushing ke origin/$BRANCH..." -- git push origin "$BRANCH"

gum style --bold --foreground "green" "✅ Proses Selesai! Perubahan Anda telah di-push ke branch $BRANCH."