# Biopkgs

Biopkgs is a collection of packages for the [Nix](https://nixos.org/nix/)
package manager. This collection contains mainly bioinformatic applications and
libraries, and it is maintained independently from the official
[Nixpkgs](https://github.com/NixOS/nixpkgs) tree because

1. Biopkgs will keep multiple versions of each package to facilitate
	 reproducibility of research results.
2. Biopkgs will add or update packages in a rolling manner.
3. Biopkgs will not require that packages be split into modular pieces, nor will
	 it require that packages be always compiled against shared libraries.


Nix is a suitable package manager for fast-paced research software development, because it natively
allows for multiple versions of packages (especially C and C++ libraries). Its
requirement for full specification of package dependencies within a functional
framework facilitates code compilation across Unix-like platforms.


## Requirement

- [Nix](https://nixos.org/nix/download.html)


## Installation

There is propbably a smarter way of distributing this package collection, but 
for now, you should clone the repository in your `$HOME` directory:

```bash
cd
git clone https://github.com/djhshih/biopkgs
```

Then, you may list the available packages in Biopkgs by

```bash
nix-env -f ~/biopkgs -qa
```

To install a package (e.g. samtools), run

```bash
nix-env -f ~/biopkgs -i samtools
```


## See also

[Nix Package Manager Guide](http://nixos.org/nix/manual/)  
[Nixpkgs Contributors Guide](http://nixos.org/nixpkgs/manual/)  


## Contribute

Submit a pull request for each package. Please ensure that your package
builds successfully before submitting.

