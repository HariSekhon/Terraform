#!/usr/bin/env bash
#  vim:ts=4:sts=4:sw=4:et
#
#  Author: Hari Sekhon
#  Date: 2022-06-10 14:09:17 +0100 (Fri, 10 Jun 2022)
#
#  https://github.com/HariSekhon/Terraform
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback
#
#  https://www.linkedin.com/in/HariSekhon
#

set -euo pipefail
[ -n "${DEBUG:-}" ] && set -x
srcdir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

die(){
    echo "ERROR: $*"
    exit 1
}

usage(){
    echo "$*"
    echo
    echo "usage: ${0##*/} NAME path/to/directory"
    echo
    exit 3
}

if [ $# -ne 2 ]; then
    usage
fi

for arg; do
    case "$arg" in
    -h|--help)  usage
                ;;
           -*)  usage "unknown argument: $arg"
                ;;
    esac
done

NAME="$1"
DIR="$2"

check_dir(){
    local dir="$1"
    if ! [ -d "$dir" ]; then
        die "directory does not exist: $dir"
    fi
}

# copied from https://github.com/HariSekhon/DevOps-Bash-tools
if [ "$(uname -s)" = Darwin ]; then
    readlink(){
        command greadlink "$@"
    }
    if ! type -P greadlink &>/dev/null; then
        die "you are on Mac and must install GNU coreutils to get greadlink (if using HomeBrew package manager you can just 'brew install coreutils')"
    fi
fi

if ! [[ "$NAME" =~ ^[[:alnum:][:space:]_-]+$ ]]; then
    die "invalid name given - may only contain these characters: alphanumeric, spaces, dashes and underscores"
fi

name="${NAME//[[:space:]]/-}"
name="$(tr '[:upper:]' '[:lower:]' <<< "$name")"

# copied from https://github.com/HariSekhon/DevOps-Bash-tools/blob/master/lib/git.sh
git_root="$(git rev-parse --show-toplevel)"
check_dir "$git_root"

if ! [ -d "$DIR" ]; then
    DIR="$git_root/$DIR"
fi

# absolute path
dir="$(readlink -f "$DIR")"

# relative path from the top of the repo - this is who GitHub Actions workflows sees it
dir="${dir#$git_root/}"
if [[ "$dir" =~ .github ]]; then
    die "Terraform code cannot live under .github/ directory"
fi

cd "$git_root"

check_dir "$dir"

cd "$srcdir/.github/workflows"

for x in plan apply; do
    template="$PWD/terraform-$x.yaml.template"
    filename="$PWD/terraform-$name-$x.yaml"
    if ! [ -f "$template" ]; then
        die "template not found: $template"
    fi
    if [ -e "$filename" ]; then
        die "file '$filename' already exists, not overwriting for safety, you must explicitly remove it first"
    fi
    sed "
        s|.github/workflows/terraform-NAME|.github/workflows/$name|g;
        s|NAME|$NAME|g;
        s|path/to/my/directory|$dir|g
    " "$template"  > "$filename"
    echo "Generated workflow: $filename"
    git add "$filename"
done
echo
echo "Workflow files are staged for next Git commit"
