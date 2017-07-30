# Z80 Boilerplate

This is very much work in progress and I encourage you to get involved with it's development.

As a new developer with z80 on the ZX Spectrum, I wanted a starting point where I could start each new project quickly and easily. I wanted to use [Pasmo](http://pasmo.speccy.org/) to assemble the code as this seemed the most popular choice.

I have started this boilerplate, which will eventually include lots of routines in the library for various purposes.  As I said, this is very much work in progress, and very much welcome your contributions.

# Includes
* Simple to use build batch script with command options (build.bat --help).

# Planned Features
* Simple to use boilerplate for any z80 project
* Segmented library of routines
* Complete list of z80 memory addresses
* More to follow...

# Build Script (Options)
* -debug (default) : Assemble file to binary as '.bin' for monitoring / debugging in emulator.
* -release         : Assemble file to self executing '.tap' file.
* -clean           : Deletes all previously built binary files.
