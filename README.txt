Drug Discovery Tool - DDT

Studying ligand-receptor complexes using VMD

INSTALLATION GUIDE
===============================================================================

Requirements
-------------------------------------------------------------------------------

-VMD 1.9.1 or later


Installation
-------------------------------------------------------------------------------

You will need write privileges in VMD's program directory.

1. Extract the distribution archive.

2. Copy the DDT subfolder (NOT the whole DDT-release distribution folder!)
   into $VMDDIR/plugins/noarch/tcl/

3. Copy the file loadDDT.tcl into the $VMDDIR/scripts/init.d/
   folder (create such folder if it does not exist).

The plugin should appear in the "Extensions" menu upon VMD's next run.


Required libraries
-------------------------------------------------------------------------------

The proper installation of DDT requires the presence of the tooltip and bwidget
libraries. If they aren't already present in your VMD distribution, copies are 
provided in the DDT-release distribution folder. You can copy the directory 
tooltip/ and bwidget-1.9.11/ inside the directories
$VMDDIR/scripts/tcl8.5 and $VMDDIR/scripts/tcl8/8.x (x= 3,4,5), or source the 
two libraries with the commands "source /path/to/libraries/tooltip/tooltip.tcl" 
and "source /path/to/libraries/bwidget-1.9.11/++++++.tcl".


Usage without installation
-------------------------------------------------------------------------------

The user can load the DDT plugin without installation by issuing a "source 
$VMDDIR/plugins/noarch/tcl/DDT/ddt.tcl" command in the TK console.
