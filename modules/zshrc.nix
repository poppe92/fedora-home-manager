{ 
  pkgs,
  ... 
}: {

  programs.zsh = {
    enable = true;
    shellAliases = {
      ls = "eza --sort newest --icons=auto --color=auto";
      lst = "eza --tree --icons=auto --color=auto";
      ll = "eza -lah --sort newest --icons=auto --color=auto";
      cat = "bat --theme Dracula";
      whatsmypublicip = "curl -4L myip.0xa.se";
      vim = "nvim";
      nvim-tc = "NVIM_APPNAME=\"nvim-typecraft\" nvim";
      recursiveDiskUsage = "du -aBM 2>/dev/null | sort -nr | head -n 50 | more";
      # idea = "${pkgs.jetbrains.idea-ultimate}/idea-ultimate/bin/idea.sh \"$1\" > /dev/null 2>&1 &";
    };
    oh-my-zsh = {
      enable = true;
      theme = "af-magic";
      plugins = ["git" "mvn" "fzf" ];
    };
    syntaxHighlighting.enable = true;
      autosuggestion = {
      enable = true;
      strategy = [ "history" "completion" ];
    };
    initContent = ''
      export PATH="$HOME/.local/bin:$PATH"

      # ---------------------
      # eza universal Dracula
      # ---------------------
      export EZA_COLORS="\
        uu=36:\
        uR=31:\
        un=35:\
        gu=37:\
        da=2;34:\
        ur=34:\
        uw=95:\
        ux=36:\
        ue=36:\
        gr=34:\
        gw=35:\
        gx=36:\
        tr=34:\
        tw=35:\
        tx=36:\
        xx=95:"

      bindkey '^ ' autosuggest-accept

      # Azure CLI tools and utilities
      azlogs() {
        echo "Finding all Container Apps in current subscription..."
        echo "Current subscription: $(az account show --query name -o tsv)"
        echo ""

        # Get all container apps with their resource groups
        local container_apps=$(az containerapp list --query '[].{name:name, resourceGroup:resourceGroup, state:properties.runningStatus}' -o tsv)
        if [[ -z "$container_apps" ]]; then
            echo "No Container Apps found in current subscription."
            return 1
        fi

        # Convert to array and display table
        local apps=()
        local index=1
        
        echo "Available Container Apps:"
        echo "─────────────────────────────────────────────────────────────────────────────────────────────"
        printf "%-4s %-35s %-40s %-15s\n" "IDX" "NAME" "RESOURCE GROUP" "STATUS"
        echo "─────────────────────────────────────────────────────────────────────────────────────────────"

        while IFS=$'\t' read -r name rg state; do
            apps+=("$name|$rg")
            printf "%-4s %-35s %-40s %-15s\n" "$index" "$name" "$rg" "$state"
            ((index++))
        done <<< "$container_apps"

        echo "─────────────────────────────────────────────────────────────────────────────────────────────"
        echo ""

        # Prompt for selection
        while true; do
            echo -n "Select Container App index (1-$((index-1)), or 'q' to quit): "
            read selection
            
            if [[ "$selection" == "q" ]] || [[ "$selection" == "Q" ]]; then
                echo "Exiting azlogs..."
                return 0
            fi
            
            if [[ "$selection" =~ ^[0-9]+$ ]] && [[ "$selection" -ge 1 ]] && [[ "$selection" -lt "$index" ]]; then
                break
            else
                echo "Invalid selection. Please enter a number between 1 and $((index-1)), or 'q' to quit."
            fi
        done

        # Extract selected app details (zsh arrays are 1-indexed)
        local selected_app="''${apps[$selection]}"
        local app_name="''${selected_app%|*}"
        local resource_group="''${selected_app#*|}"

        echo ""
        echo "Following logs for Container App: $app_name"
        echo "Resource Group: $resource_group"

        # If the user passed arguments to azlogs, use them; otherwise default to --follow
        local extra_args
        if [[ $# -gt 0 ]]; then
            extra_args=("-n $@")
        else
            extra_args=("--follow")
        fi

        # Build a clipboard-friendly command string (quote names)
        local extra_args_str="''${(j: :)extra_args}"
        local clip_cmd="az containerapp logs show -g '$resource_group' -n '$app_name' --format text --type console ''${extra_args_str}"
        echo "$clip_cmd" | wl-copy -selection clipboard
        echo "-- copied logs cmd to Clipboard"
        echo "Starting log stream... (Press Ctrl+C to stop)"
        echo ""
        echo "────────────────────────────────────────────────────────────────────────────────"

        # Execute logs command with proper argument array
        az containerapp logs show \
            --name "$app_name" \
            --resource-group "$resource_group" \
            --type console \
            --format text \
            "''${(@)extra_args[@]}"
      }

      # Switch Azure subscription by fuzzy matching the provided search words against a
      # curated list of subscription names. Usage: azs <search words...>
      azs() {
        local -a subscriptions
        subscriptions=(
              "FRAC NORDIC - ES - NFS Dev"
              "FRAC NORDIC - ES - NFS Prod"
              "FRAC NORDIC - ES - NFS Test"
              "FRAC NORDIC - ES - Damage Solution Prod"
              "FRAC NORDIC - ES - Damage Solution Test"
              "FRAC NORDIC - ES - Shared Services Dev"
              "FRAC NORDIC - ES - Shared Services Prod"
              "FRAC NORDIC - ES - Shared Services Test"
              "FRAC NORDIC - ES - Core Rental Services Prod"
              "FRAC NORDIC - ES - Core Rental Services Test"
              "FRAC NORDIC - ES - Payment Test"
              "FRAC NORDIC - ES - Payment Prod"
              "FRAC NORDIC - ES - AKS Dev/Test"
              "FRAC NORDIC - ES - AKS Prod"
              "FRAC NORDIC - ES - Customer Common Prod"
              "FRAC NORDIC - ES - Customer Common Test"
              "FRAC NORDIC - ES - Customer Journey Prod"
              "FRAC NORDIC - ES - Customer Journey Test"
              "FRAC NORDIC - ES - Customer Solution Prod"
              "FRAC NORDIC - ES - Customer Solution Test"
              "FRAC NORDIC - ES - CIS Hertz Dev"
              "FRAC NORDIC - ES - CIS Hertz Prod"
              "FRAC NORDIC - ES - CIS Hertz Test"
              "FRAC NORDIC - ES - Digital Agreement Signature Prod"
              "FRAC NORDIC - ES - Digital Agreement Signature Test"
              "FRAC NORDIC - ES - Parkeringsbot Dev"
              "FRAC NORDIC - ES - Parkeringsbot Prod"
        )
        if [[ $# -eq 0 ]]; then
              echo "Usage: azs <search words...>"
              return 2
        fi

        # prepare search words in lowercase
        local -a words
        local w
        for w in "$@"; do
              # remove double-quote characters if present and lowercase
              w=''${w//\"/}
              words+=("''${(L)w}")
        done
        # helper: normalize a string (lowercase)
        local normalize
        normalize() { echo "$1" | tr '[:upper:]' '[:lower:]'; }
        # helper: check if pattern is subsequence of text
        subseq() {
          local text="$1"
          local pattern="$2"
          local ti=0
          local pi=0
          local tlen=''${#text}
          local plen=''${#pattern}
          while (( ti < tlen && pi < plen )); do
            if [[ ''${text:ti:1} = ''${pattern:pi:1} ]]; then
              ((pi++))
            fi
            ((ti++))
          done
          (( pi == plen ))
        }
        local best_index=-1
        local best_score=0

        # First pass: find first subscription that contains all words (any order)
        local i=0
        for sub in "''${subscriptions[@]}"; do
          local sub_lc=$(normalize "$sub")
          local matched_all=true
          for w in "''${words[@]}"; do
            if [[ "$sub_lc" != *"''${w}"* ]]; then
              matched_all=false
              break
            fi
          done
          if $matched_all; then
            chosen="$sub"
            echo "Selected subscription: $chosen"
            az account set -n "$chosen"
            return $?
          fi
          ((i++))
        done
        echo "No subscription matched: $*"
        return 3
      }

      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi

      fortune | cowsay | lolcat
    '';
  };

}
