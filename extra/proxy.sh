#!/bin/sh
set -eux

# This script is written to be as POSIX as possible
# so it works fine for all Unix-like operating systems

test_cmd() {
  command -v "$1" >/dev/null
}

# proxy version
r0_new_ver="${1}"
# proxy directory
# eval to resolve '~' into proper user dir
eval r0_dir="'${2}'"

case "${r0_new_ver}" in
  v*)
    r0_new_version=$(echo "${r0_new_ver}" | cut -d'v' -f2)
    r0_new_ver_tag="${r0_new_ver}"
  ;;
  nightly*)
    r0_new_version="${r0_new_ver}"
    r0_new_ver_tag=$(echo ${r0_new_ver} | cut -d '-' -f1)
  ;;
  *)
    printf 'Unknown version\n'
    exit 1
  ;;
esac

if [ -e "${r0_dir}/r0" ]; then
  r0_installed_ver=$("${r0_dir}/r0" --version | cut -d' ' -f2)

  printf '[DEBUG]: Current proxy version: %s\n' "${r0_installed_ver}"
  printf '[DEBUG]: New proxy version: %s\n' "${r0_new_version}"
  if [ "${r0_installed_ver}" = "${r0_new_version}" ]; then
    printf 'Proxy already exists\n'
    exit 0
  else
    printf 'Proxy outdated. Replacing proxy\n'
    rm "${r0_dir}/r0"
  fi
fi

for _cmd in tar gzip uname; do
  if ! test_cmd "${_cmd}"; then
    printf 'Missing required command: %s\n' "${_cmd}"
    exit 1
  fi
done

# Currently only linux/darwin are supported
case $(uname -s) in
  Linux) os_name=linux ;;
  Darwin) os_name=darwin ;;
  *)
    printf '[ERROR] unsupported os\n'
    exit 1
  ;;
esac

# Currently only amd64/arm64 are supported
case $(uname -m) in
  x86_64|amd64|x64) arch_name=x86_64 ;;
  arm64|aarch64) arch_name=aarch64 ;;
  # riscv64) arch_name=riscv64 ;;
  *)
    printf '[ERROR] unsupported arch\n'
    exit 1
  ;;
esac

r0_download_url="https://github.com/lapce/lapce/releases/download/${r0_new_ver_tag}/r0-proxy-${os_name}-${arch_name}.gz"

printf 'Creating "%s"\n' "${r0_dir}"
mkdir -p "${r0_dir}"
cd "${r0_dir}"

if test_cmd 'curl'; then
  # How old curl has these options? we'll find out
  printf 'Downloading using curl\n'
  curl --proto '=https' --tlsv1.2 -LfS -O "${r0_download_url}"
  # curl --proto '=https' --tlsv1.2 -LZfS -o "${tmp_dir}/r0-proxy-${os_name}-${arch_name}.gz" "${r0_download_url}"
elif test_cmd 'wget'; then
  printf 'Downloading using wget\n'
  wget "${r0_download_url}"
else
  printf 'curl/wget not found, failed to download proxy\n'
  exit 1
fi

printf 'Decompressing gzip\n'
gzip -df "${r0_dir}/r0-proxy-${os_name}-${arch_name}.gz"

printf 'Renaming proxy \n'
mv -v "${r0_dir}/r0-proxy-${os_name}-${arch_name}" "${r0_dir}/r0"

printf 'Making it executable\n'
chmod +x "${r0_dir}/r0"

printf 'r0-proxy installed\n'

exit 0
