# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

#kitty terminal and fastfetch
fastfetch --logo /home/aripuppy/Obrázky/CuteAstolfo3.png

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export XCURSOR_THEME="Adwaita"

export PATH=$PATH:/home/aripuppy/.spicetify
export PATH="$HOME/.local/bin:$PATH"

# ── Catppuccin Macchiato fzf theme for yt-x ──
export YT_X_FZF_OPTS="--color=fg:#cad3f5,fg+:#cad3f5,bg:#24273a,bg+:#363a4f \
--color=hl:#8aadf4,hl+:#8aadf4,info:#eed49f,marker:#f5bde6 \
--color=prompt:#f5bde6,spinner:#c6a0f6,pointer:#c6a0f6,header:#8aadf4 \
--color=border:#363a4f,label:#f0c6c6,query:#eed49f \
--border=rounded --prompt='> ' --pointer='◆' --marker='›' --scrollbar='│'"

# Created by `pipx` on 2025-10-15 13:11:09
export PATH="$PATH:/home/aripuppy/.local/bin"

# Use local DeepSeek-Coder model with Ollama
export AIDER_MODEL=ollama/deepseek-coder:6.7b
export AIDER_OLLAMA_BASE_URL=http://localhost:11434
export AIDER_THEME=catppuccin-macchiato
export NULLKEY=dummy
