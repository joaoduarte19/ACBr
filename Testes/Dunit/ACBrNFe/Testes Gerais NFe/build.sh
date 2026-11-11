#!/bin/bash
# Compila os testes do TACBrNFe contra os fontes do ACBr.
#   bin/TestesNFe.exe          runner GRAFICO (VCL)
#   bin/TestesNFe_Console.exe  runner console (CI / linha de comando)
#
# Variaveis de ambiente opcionais:
#   ACBR_DIR  raiz do ACBr (padrao C:\ACBr)       - fontes, schemas, DLLs
#   BDS       pasta do Delphi (padrao Studio 37.0) - dcc32.exe e DUnitX
set -e
cd "$(dirname "$0")"

ACBR_DIR="${ACBR_DIR:-C:/ACBr}"
BDS="${BDS:-C:/Program Files (x86)/Embarcadero/Studio/37.0}"
ACBR_UNIX=$(cygpath -u "$ACBR_DIR" 2>/dev/null || echo "$ACBR_DIR")
DCC="$(cygpath -u "$BDS" 2>/dev/null || echo "$BDS")/bin/dcc32.exe"

# DLLs (32 bits) usadas pelos testes: OpenSSL 3 e LibXml2 do proprio ACBr
mkdir -p bin
for dll in "$ACBR_UNIX/DLLs/OpenSSL/3.1.3/x86/"*.dll "$ACBR_UNIX/DLLs/LibXml2/x86/"*.dll; do
  [ -f "bin/$(basename "$dll")" ] || cp "$dll" bin/
done

UPATH=$(find "$ACBR_UNIX/Fontes" -type d ! -path '*__history*' ! -path '*__recovery*' ! -path '*/.svn*' \
        | sed 's|^/\([a-zA-Z]\)/|\1:/|' | tr '\n' ';')
UPATH="$UPATH$BDS/source/DUnitX;$BDS/lib/win32/release"

# Compila em pasta temporaria e so entao move para bin\ (falha se o exe estiver aberto)
compilar() {   # $1 = nome do exe, $2 = defines
  local tmp="dcu/out_$1"
  mkdir -p "dcu/$1" "$tmp"
  rm -f "$tmp/TestesNFe.exe"
  echo "== $1"
  # $R+ $Q+ : mesmas verificacoes de faixa/overflow da configuracao Debug do IDE
  if ! "$DCC" -B -Q -W- -H- '-$R+' '-$Q+' \
      "-NSSystem;Winapi;System.Win;Data;Datasnap;Xml;Vcl;Vcl.Imaging;Soap;Web" \
      -U"$UPATH" -I"$UPATH" -R"$UPATH" -N0"dcu/$1" -E"$tmp" $2 TestesNFe.dpr > "$tmp/build.log" 2>&1; then
    grep -i "error\|fatal" "$tmp/build.log" | head -20
    echo "ERRO: falha ao compilar $1"
    return 1
  fi
  tail -1 "$tmp/build.log"
  if ! mv -f "$tmp/TestesNFe.exe" "bin/$1.exe" 2>/dev/null; then
    echo "ERRO: bin/$1.exe esta em uso (feche o programa)"
    return 1
  fi
}

compilar TestesNFe_Console -DCONSOLE_TESTRUNNER
compilar TestesNFe ""
ls -la bin/TestesNFe.exe bin/TestesNFe_Console.exe
