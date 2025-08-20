#!/usr/bin/env python3
"""
Git Commit Helper - Interactive CLI Tool
Membantu membuat commit dengan format conventional commits
"""

import os
import sys
import subprocess
import argparse
from typing import List, Optional

class Colors:
    """ANSI color codes untuk output yang berwarna"""
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    CYAN = '\033[96m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    BOLD = '\033[1m'
    UNDERLINE = '\033[4m'
    END = '\033[0m'

class GitCommitHelper:
    def __init__(self):
        # Konfigurasi opsi untuk conventional commits
        self.type_options = [
            ("feat", "Fitur baru untuk pengguna"),
            ("fix", "Perbaikan bug"),
            ("docs", "Perubahan dokumentasi"),
            ("style", "Perubahan format/styling (tanpa mengubah logika)"),
            ("refactor", "Refactoring kode (tidak menambah fitur/fix bug)"),
            ("test", "Menambah atau memperbaiki test"),
            ("chore", "Maintenance, update dependencies, build tools"),
            ("ci", "Perubahan pada CI/CD pipeline"),
            ("build", "Perubahan pada build system atau dependencies"),
        ]
        
        self.scope_options = [
            ("api", "Perubahan pada API"),
            ("ui", "Perubahan antarmuka pengguna"),
            ("db", "Perubahan database/model"),
            ("auth", "Sistem otentikasi/otorisasi"),
            ("ci", "Continuous Integration"),
            ("docs", "Dokumentasi"),
        ]
    
    def print_header(self, title: str):
        """Mencetak header dengan style"""
        print(f"\n{Colors.CYAN}{'='*60}{Colors.END}")
        print(f"{Colors.BOLD}{Colors.CYAN}{title:^60}{Colors.END}")
        print(f"{Colors.CYAN}{'='*60}{Colors.END}")
    
    def print_info(self, message: str):
        """Mencetak informasi dengan warna"""
        print(f"{Colors.BLUE}ℹ️  {message}{Colors.END}")
    
    def print_success(self, message: str):
        """Mencetak pesan sukses"""
        print(f"{Colors.GREEN}✅ {message}{Colors.END}")
    
    def print_warning(self, message: str):
        """Mencetak peringatan"""
        print(f"{Colors.YELLOW}⚠️  {message}{Colors.END}")
    
    def print_error(self, message: str):
        """Mencetak error"""
        print(f"{Colors.RED}❌ {message}{Colors.END}")
    
    def run_command(self, command: List[str]) -> tuple:
        """Menjalankan command dan mengembalikan (success, output, error)"""
        try:
            result = subprocess.run(command, capture_output=True, text=True)
            return result.returncode == 0, result.stdout.strip(), result.stderr.strip()
        except Exception as e:
            return False, "", str(e)
    
    def get_git_status(self) -> List[str]:
        """Mendapatkan daftar file yang berubah"""
        success, output, _ = self.run_command(['git', 'status', '--porcelain'])
        if not success:
            return []
        
        files = []
        for line in output.split('\n'):
            if line.strip():
                # Format: "XY filename" dimana X dan Y adalah status
                status = line[:2]
                filename = line[3:]
                files.append((status, filename))
        return files
    
    def get_current_branch(self) -> str:
        """Mendapatkan nama branch saat ini"""
        success, output, _ = self.run_command(['git', 'branch', '--show-current'])
        return output if success else "unknown"
    
    def select_from_menu(self, options: List[tuple], title: str, allow_custom: bool = True) -> str:
        """Menampilkan menu pilihan dan mengembalikan pilihan user"""
        print(f"\n{Colors.BOLD}{title}{Colors.END}")
        print(f"{Colors.UNDERLINE}Pilihan yang tersedia:{Colors.END}")
        
        for i, (value, description) in enumerate(options, 1):
            print(f"{Colors.CYAN}{i:2d}.{Colors.END} {Colors.BOLD}{value}{Colors.END} - {description}")
        
        if allow_custom:
            print(f"{Colors.CYAN}{len(options)+1:2d}.{Colors.END} {Colors.YELLOW}[Ketik manual]{Colors.END}")
        
        while True:
            try:
                choice = input(f"\n{Colors.BOLD}Pilih nomor (1-{len(options) + (1 if allow_custom else 0)}): {Colors.END}")
                choice_num = int(choice)
                
                if 1 <= choice_num <= len(options):
                    selected = options[choice_num - 1][0]
                    print(f"{Colors.GREEN}Dipilih: {selected}{Colors.END}")
                    return selected
                elif allow_custom and choice_num == len(options) + 1:
                    custom = input(f"{Colors.YELLOW}Ketik pilihan kustom: {Colors.END}").strip()
                    if custom:
                        return custom
                    print(f"{Colors.RED}Input tidak boleh kosong!{Colors.END}")
                else:
                    print(f"{Colors.RED}Pilihan tidak valid!{Colors.END}")
            except ValueError:
                print(f"{Colors.RED}Masukkan angka yang valid!{Colors.END}")
            except KeyboardInterrupt:
                print(f"\n{Colors.YELLOW}Dibatalkan oleh user{Colors.END}")
                sys.exit(1)
    
    def select_files(self, files: List[tuple]) -> bool:
        """Memilih file untuk di-add ke staging area"""
        self.print_header("LANGKAH 1: PILIH FILE UNTUK COMMIT")
        self.print_info("File yang berubah akan ditambahkan ke staging area sebelum commit")
        
        if not files:
            self.print_warning("Tidak ada file yang berubah untuk di-commit")
            return False
        
        print(f"\n{Colors.BOLD}File yang berubah:{Colors.END}")
        for status, filename in files:
            status_color = Colors.GREEN if 'A' in status else Colors.YELLOW if 'M' in status else Colors.RED
            print(f"  {status_color}{status}{Colors.END} {filename}")
        
        print(f"\n{Colors.BOLD}Pilihan:{Colors.END}")
        print(f"{Colors.CYAN}1.{Colors.END} {Colors.BOLD}Tambah semua file{Colors.END} - Menambahkan semua perubahan ke staging")
        print(f"{Colors.CYAN}2.{Colors.END} {Colors.BOLD}Pilih file manual{Colors.END} - Memilih file satu per satu")
        
        while True:
            try:
                choice = input(f"\n{Colors.BOLD}Pilih opsi (1-2): {Colors.END}")
                if choice == "1":
                    success, _, error = self.run_command(['git', 'add', '.'])
                    if success:
                        self.print_success("Semua file berubah telah ditambahkan ke staging")
                        return True
                    else:
                        self.print_error(f"Gagal menambahkan file: {error}")
                        return False
                elif choice == "2":
                    return self._select_files_manually(files)
                else:
                    print(f"{Colors.RED}Pilihan tidak valid!{Colors.END}")
            except KeyboardInterrupt:
                print(f"\n{Colors.YELLOW}Dibatalkan oleh user{Colors.END}")
                sys.exit(1)
    
    def _select_files_manually(self, files: List[tuple]) -> bool:
        """Memilih file secara manual"""
        print(f"\n{Colors.BOLD}Pilih file untuk di-add (ketik nomor, pisahkan dengan spasi):{Colors.END}")
        
        for i, (status, filename) in enumerate(files, 1):
            status_color = Colors.GREEN if 'A' in status else Colors.YELLOW if 'M' in status else Colors.RED
            print(f"{Colors.CYAN}{i:2d}.{Colors.END} {status_color}{status}{Colors.END} {filename}")
        
        while True:
            try:
                choices = input(f"\n{Colors.BOLD}Masukkan nomor file (contoh: 1 3 5): {Colors.END}").strip()
                if not choices:
                    self.print_warning("Tidak ada file yang dipilih")
                    return False
                
                indices = [int(x) - 1 for x in choices.split()]
                selected_files = []
                
                for idx in indices:
                    if 0 <= idx < len(files):
                        selected_files.append(files[idx][1])
                    else:
                        print(f"{Colors.RED}Nomor {idx+1} tidak valid!{Colors.END}")
                        continue
                
                if selected_files:
                    for file in selected_files:
                        success, _, error = self.run_command(['git', 'add', file])
                        if not success:
                            self.print_error(f"Gagal menambahkan {file}: {error}")
                            return False
                    
                    self.print_success(f"File terpilih telah ditambahkan: {', '.join(selected_files)}")
                    return True
                
            except ValueError:
                print(f"{Colors.RED}Format input tidak valid! Gunakan angka dipisahkan spasi{Colors.END}")
            except KeyboardInterrupt:
                print(f"\n{Colors.YELLOW}Dibatalkan oleh user{Colors.END}")
                sys.exit(1)
    
    def create_commit_message(self) -> str:
        """Membuat pesan commit secara interaktif"""
        self.print_header("LANGKAH 2: BUAT PESAN COMMIT")
        self.print_info("Menggunakan format Conventional Commits: type(scope): subject")
        
        # Pilih tipe commit
        commit_type = self.select_from_menu(
            self.type_options, 
            "🏷️  Pilih Tipe Commit:",
            allow_custom=True
        )
        
        # Pilih scope (opsional)
        print(f"\n{Colors.BOLD}🎯 Pilih Scope Commit (Opsional):{Colors.END}")
        print(f"{Colors.YELLOW}Scope menjelaskan bagian mana dari kode yang terpengaruh{Colors.END}")
        
        scope_options_with_skip = self.scope_options + [("", "Skip - Tanpa scope")]
        commit_scope = self.select_from_menu(
            scope_options_with_skip,
            "",
            allow_custom=True
        )
        
        # Input subject
        print(f"\n{Colors.BOLD}📝 Tulis Subject Commit:{Colors.END}")
        print(f"{Colors.YELLOW}Subject harus singkat, jelas, dan menjelaskan apa yang dilakukan{Colors.END}")
        print(f"{Colors.YELLOW}Contoh: 'add user authentication', 'fix navbar responsive issue'{Colors.END}")
        
        while True:
            subject = input(f"\n{Colors.BOLD}Subject: {Colors.END}").strip()
            if subject:
                break
            print(f"{Colors.RED}Subject tidak boleh kosong!{Colors.END}")
        
        # Rakit pesan commit
        if commit_scope and commit_scope.strip():
            commit_message = f"{commit_type}({commit_scope}): {subject}"
        else:
            commit_message = f"{commit_type}: {subject}"
        
        # Tampilkan preview
        print(f"\n{Colors.BOLD}👀 Preview Pesan Commit:{Colors.END}")
        print(f"{Colors.GREEN}┌{'─' * (len(commit_message) + 2)}┐{Colors.END}")
        print(f"{Colors.GREEN}│ {Colors.BOLD}{commit_message}{Colors.END}{Colors.GREEN} │{Colors.END}")
        print(f"{Colors.GREEN}└{'─' * (len(commit_message) + 2)}┘{Colors.END}")
        
        return commit_message
    
    def confirm_and_push(self, commit_message: str) -> bool:
        """Konfirmasi dan push commit"""
        self.print_header("LANGKAH 3: KONFIRMASI & PUSH")
        
        branch = self.get_current_branch()
        print(f"{Colors.BOLD}Branch saat ini: {Colors.CYAN}{branch}{Colors.END}")
        print(f"{Colors.BOLD}Pesan commit: {Colors.GREEN}{commit_message}{Colors.END}")
        
        while True:
            confirm = input(f"\n{Colors.BOLD}Lanjutkan commit dan push? (y/n): {Colors.END}").lower().strip()
            if confirm in ['y', 'yes', 'ya']:
                break
            elif confirm in ['n', 'no', 'tidak']:
                self.print_warning("Proses dibatalkan oleh user")
                return False
            else:
                print(f"{Colors.RED}Masukkan 'y' atau 'n'!{Colors.END}")
        
        # Commit
        print(f"\n{Colors.YELLOW}🔄 Melakukan commit...{Colors.END}")
        success, _, error = self.run_command(['git', 'commit', '-m', commit_message])
        if not success:
            self.print_error(f"Gagal commit: {error}")
            return False
        
        self.print_success("Commit berhasil!")
        
        # Push
        print(f"{Colors.YELLOW}🚀 Pushing ke origin/{branch}...{Colors.END}")
        success, _, error = self.run_command(['git', 'push', 'origin', branch])
        if not success:
            self.print_error(f"Gagal push: {error}")
            return False
        
        self.print_success(f"Berhasil push ke branch {branch}!")
        return True
    
    def run(self):
        """Menjalankan program utama"""
        print(f"{Colors.BOLD}{Colors.CYAN}")
        print("╔════════════════════════════════════════╗")
        print("║        GIT COMMIT HELPER v1.0          ║")
        print("║     Interactive Conventional Commits   ║")
        print("╚════════════════════════════════════════╝")
        print(f"{Colors.END}")
        
        # Cek apakah berada di git repository
        success, _, _ = self.run_command(['git', 'rev-parse', '--git-dir'])
        if not success:
            self.print_error("Tidak berada di dalam git repository!")
            sys.exit(1)
        
        try:
            # Langkah 1: Pilih file
            files = self.get_git_status()
            if not self.select_files(files):
                sys.exit(1)
            
            # Langkah 2: Buat pesan commit
            commit_message = self.create_commit_message()
            
            # Langkah 3: Konfirmasi dan push
            if self.confirm_and_push(commit_message):
                print(f"\n{Colors.GREEN}{Colors.BOLD}🎉 PROSES SELESAI! 🎉{Colors.END}")
                print(f"{Colors.GREEN}Perubahan Anda telah berhasil di-commit dan di-push!{Colors.END}")
            
        except KeyboardInterrupt:
            print(f"\n\n{Colors.YELLOW}Program dihentikan oleh user{Colors.END}")
            sys.exit(1)
        except Exception as e:
            self.print_error(f"Terjadi error: {str(e)}")
            sys.exit(1)

def main():
    parser = argparse.ArgumentParser(
        description="Git Commit Helper - Interactive CLI tool untuk conventional commits"
    )
    parser.add_argument(
        '--version', 
        action='version', 
        version='Git Commit Helper v1.0'
    )
    
    args = parser.parse_args()
    
    helper = GitCommitHelper()
    helper.run()

if __name__ == "__main__":
    main()