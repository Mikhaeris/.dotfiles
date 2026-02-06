# How it works:
First of all scipts have one entery point, just simple, right? with only two parameters: mode and ask_agrs
All we need it know release or debug it and we need args?(i think yes)

in some options need to tests and valgring.
It easy to add in main.lua, add new parameters, for run tests or run with valgrind

Some way you alright its not vim philosphy, and vim have :make command, its good, but in my opinion its in vim phisophy we make our worflow with our options we need. I really like how can easy build and run program in some IDE, its speed, but in this you have many options how do it, because speed and options it in vim philosophy

### main.lua:
run(mode, ask_agrs)
1) Save files (really good)
2) Detect/find build systems
3) Make path (`./build/{build_type}/main`)
4) Build
5) If error - just show it and halt
6) Get Args (exactly after build, because what we do with args if program is bad, i think many programs are bad)
7) Run (if debug - Dap, if Release - just run it)

It's simple

### detector.lua
In current directory find (build.sh, Makefiles or CmakeLists.txt...)

**`TODO:`** modernize need

### builder.lua
jush execute formating string by parameters

### ui.lua

mb need how split this logic in two files

if error - show errors

run in terminal - run program in terminal

run_dap - run debbuger with ui (really need to update)

Thats all!

P.S. and TODO
Need to add tests and valgring
Add simple start (like run this file witout any systems)
Update detector (mb need hash table for quick detect system in current directory)
Update run_dap for other debbuger, Like language - dap connfig
Add default build.sh, Makefiles, CmakeLists.txt and other systems.
(Test for programs may different, need to think about it)

Add config directory to easy config/ Like for one language, for build systems, where to find, add custom key_maps/
