@echo off
::declares all weapon damages and speeds

::fists, you start with them
set fists.dmg=2d3d1
set fists.acc=1
set fists.spd=1.0

::knife melee weapons

::combat knife
set combat.knife.dmg=2d4d1
set combat.knife.acc=3
set combat.knife.spd=0.9

::hunting knife
set hunting.knife.dmg=2d5d1
set hunting.knife.acc=2
set hunting.knife.spd=1.0

::penknife
set pen.knife.dmg=1d4d1

::sword melee weapons
set short.sword.dmg=2d6d1
set broad.sword.dmg=3d6d1
set steel.sword.dmg=4d3d1

::special melee weapons
set sp.chainsaw.dmg=4d6d1
set sp.trident=3d6d3
set sp.sythe=5d7d1

::unique melee weapons
set uq.butchercleave=5d6d1
set uq.dragonslayer=9d9d1
set uq.weedwhacker=8d4d2
set uq.bushpruner=1d10d10

goto :eof