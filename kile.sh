#!/bin/sh -e

if [ -d /app/texlive/bin ] && [ -d /app/texlive/lib ]; then
    cd /app/texlive/lib/perl5/site_perl
    perl_version=$(ls)
    arch=$(uname -m)
    # Add paths of TeX Live Flatpak extension binaries
    export PATH=$PATH:/app/texlive/bin:/app/texlive/bin/$arch-linux
    # Add include paths for Perl @INC variable
    export PERL5LIB=/app/texlive/lib/perl5/$perl_version:/app/texlive/lib/perl5/site_perl/$perl_version
    # Add library paths
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/app/texlive/lib:/app/texlive/lib/perl5/$perl_version/$arch-linux/CORE
else
    echo "warning: missing required extension: org.freedesktop.Sdk.Extension.texlive"
fi

cd # This is required to avoid Kile closing with "Program to run not set."
exec kile "$@"
