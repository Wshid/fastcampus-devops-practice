## [CH03_02] Homebrew 설치 및 사용법
- macOS용 패키지 관리자
- CLI나 시스템 패키지 설치에 사용
- Formula: Ruby 언어로 패키지 명세
- Cask 확장을 통해 **GUI App**설치 지원
- 패키지 관련 명령어
    ```bash
    brew search
    brew info
    brew upgrade
    brew uninstall
    brew update

    # Homebrew의 확장, GUI App 설치 지원
    brew info --cask ngrok
    brew install --cask ngrok
    brew uninstall --cask ngrok
    ```
