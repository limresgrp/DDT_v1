package require tooltip
package require BWidget
package provide ddt 1.0

#====VARIABLES TO BE INITIALIZED====#

set counter_BALL 0
set counter_BOX 0
set counter_ROD 0
set RADIO 0
set RADIO2 0
set GRAPHICS 0
set MODALITY 0
set ESlist ""
set LClist ""
set NAlist ""
set MClist ""
set CLTJlist ""
set BiCLTJlist ""
set myvariable ""
set LOADEDmolVS ""
set LOADEDmolMD ""
set LOADEDmolMDtotal ""
#======GUI=====#

proc ddtGUI {} {

global w
global entry-yp2
global entryFP
global entryFP2
global ligname
global distanceNA
global entryfrom
global entryTo
global clCutoff
global clLimit
global clTorsion
global myvariable 
global MODALITY
global RADIO2
global RADIO

set w [toplevel ".ddt"]
wm title $w "DDT - DRUG DISCOVERY TOOL"
wm resizable $w 0 0

label $w.title -background blue -foreground white -text "DDT - Drug Discovery Tool" -font {Helvetica -22 bold} -relief groove -borderwidth 10 -width 35
pack $w.title -side top -ipady 5 -pady 5 -fill x

frame $w.frame1
pack $w.frame1 -padx 1 -fill x

button $w.frame1.directoryButton -background "white" -text "Directory Path:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set myvariable [tk_chooseDirectory] ; WD_setting } -width 15
tooltip::tooltip $w.frame1.directoryButton "\
 Select your own \n\
 working directory"
pack $w.frame1.directoryButton -side left

entry $w.frame1.directoryEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable myvariable -justify right
pack $w.frame1.directoryEntry -side left

message $w.frame1.message4 -background "white" -text "    Ligand name ->" -font {Helvetica -18 bold} -relief flat -borderwidth 3 -width 260
tooltip::tooltip $w.frame1.message4 "\
 Insert ligand name"
pack $w.frame1.message4 -side left -padx 1.5

entry $w.frame1.entry4 -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -width 10 -textvariable ligname -justify right -width 20
set ligname "Write here"
pack $w.frame1.entry4 -fill x

frame $w.frame9
pack $w.frame9 -padx 1 -fill x

#=====LEFT DOOR=====#

frame $w.frame9.leftpanel -relief flat -bd 2
pack $w.frame9.leftpanel -padx 1 -side left

message $w.frame9.leftpanel.message3 -background "white" -text "Receptor visualization options" -font {Helvetica -14 bold} -relief flat -borderwidth 2 -width 260
pack $w.frame9.leftpanel.message3 -fill x

radiobutton $w.frame9.leftpanel.yp1  -relief groove -width 12 -text "Default" -font {Helvetica -14} -variable RADIO -value 0
pack $w.frame9.leftpanel.yp1 -side left

radiobutton $w.frame9.leftpanel.yp2  -relief groove -width 12 -text "Free-selection" -font {Helvetica -14} -variable RADIO -value 1
pack $w.frame9.leftpanel.yp2 -side left

entry $w.frame9.leftpanel.entry-yp2 -background grey -foreground black  -font {Helvetica -16} -textvariable entry-yp2 -width 10
set entry-yp2 "Write Here"
pack $w.frame9.leftpanel.entry-yp2 -side left

#======RIGHT DOOR======#

frame $w.frame9.rightpanel -relief flat -bd 2
pack $w.frame9.rightpanel -padx 1

message $w.frame9.rightpanel.message3 -background "white" -text "Receptor type options" -font {Helvetica -14 bold} -relief flat -borderwidth 2 -width 260
pack $w.frame9.rightpanel.message3 -fill x

radiobutton $w.frame9.rightpanel.yp1  -relief groove -width 12 -text "Protein" -font {Helvetica -14} -variable RADIO2 -value 0
pack $w.frame9.rightpanel.yp1 -side left

radiobutton $w.frame9.rightpanel.yp2  -relief groove -width 12 -text "Nuclear acids" -font {Helvetica -14} -variable RADIO2 -value 1
pack $w.frame9.rightpanel.yp2 -side left

#============================#

frame $w.frame2
pack $w.frame2 -padx 1 -fill x

radiobutton $w.frame2.firstchoice  -relief groove -width 18 -text "VS PACKAGE" -font {Helvetica -14} -variable MODALITY -value 0
pack $w.frame2.firstchoice -side left

frame $w.frame3
pack $w.frame3 -padx 1 -fill x

button $w.frame3.receptorButton -background "white" -text "Receptor Pdb:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set receptor [tk_getOpenFile]} -width 15
tooltip::tooltip $w.frame3.receptorButton "\
 Select the pdb of 
 the receptor on \n\
 which you docked"
pack $w.frame3.receptorButton -side left

entry $w.frame3.receptorEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable receptor -justify right
pack $w.frame3.receptorEntry -side left -fill x

button $w.frame3.gpfButton -background "white" -text "Receptor .gpf:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set receptor-gpf [tk_getOpenFile]} -width 15
tooltip::tooltip $w.frame3.gpfButton "\
 Select the .gpf map"
pack $w.frame3.gpfButton -side left

entry $w.frame3.gpfEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable receptor-gpf -justify right
pack $w.frame3.gpfEntry -fill x

frame $w.frame4
pack $w.frame4 -padx 1 -fill x

button $w.frame4.convertButton -background "white" -text "EXTRACT" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {EXTRACT} -width 8
tooltip::tooltip $w.frame4.convertButton "\
 Extract the largest
 cluster from every dlg"
pack $w.frame4.convertButton -side left

button $w.frame4.loadButton -background "white" -foreground black -text "LOAD" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {L} -width 8
tooltip::tooltip $w.frame4.loadButton "\
 Load the VS results"
pack $w.frame4.loadButton -side left

button $w.frame4.moveonButton -background "white" -text "SAVE" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {MOVEON} -width 8
tooltip::tooltip $w.frame4.moveonButton "\
 Save the pdb on screen"
pack $w.frame4.moveonButton -side left

button $w.frame4.boxButton -background "white" -text "BOX" -font {Helvetica -18 bold} -command {BOX} -relief ridge -borderwidth 5
tooltip::tooltip $w.frame4.boxButton "\
 Show the GridBox on screen"
pack $w.frame4.boxButton -side left

message $w.frame4.filtermessage -background "white" -text " LC:" -font {Helvetica -16 bold} -relief flat -borderwidth 2
pack $w.frame4.filtermessage -side left

entry $w.frame4.entryFP -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable entryFP -width 2 -justify right -width 7
set entryFP "0"
pack $w.frame4.entryFP  -side left 

message $w.frame4.filtermessage2 -background "white" -text " ES:" -font {Helvetica -16 bold} -relief flat -borderwidth 2
pack $w.frame4.filtermessage2 -side left

entry $w.frame4.entryFP2 -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable entryFP2 -width 2 -justify right -width 7
set entryFP2 "0"
pack $w.frame4.entryFP2  -side left

button $w.frame4.filterButton -background "white" -text "FILTER" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {FILTERVS} -width 8
tooltip::tooltip $w.frame4.filterButton "\
 Select the options on
 the right and filter
 the best binding pose"
pack $w.frame4.filterButton -side left

frame $w.frame5 
pack $w.frame5 -padx 1 -fill x

message $w.frame5.spazietto -background "white" -text "       " -font {Helvetica -18 bold} -relief flat -borderwidth 3 -width 260
pack $w.frame5.spazietto -side left -padx 1.5

ArrowButton $w.frame5.arrowLEFT -background grey -type button -dir left -relief ridge -borderwidth 1 -height 37 -width 37 -clean 0 -ipadx 3 -ipady 3 -repeatdelay 333 -armcommand {q}
pack $w.frame5.arrowLEFT -side left

ArrowButton $w.frame5.arrowRIGHT -background grey -type button -dir right -relief ridge -borderwidth 1 -height 37 -width 37 -clean 0 -ipadx 3 -ipady 3 -repeatdelay 333 -armcommand {a}
pack $w.frame5.arrowRIGHT -side left

button $w.frame5.plotLCButton -background "white" -text "PLOT LC" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {LCSCORE; set counter_ROD 1} -width 8
tooltip::tooltip $w.frame5.plotLCButton "\
 Plot the popolation
 for every largest cluster"
pack $w.frame5.plotLCButton -side left

button $w.frame5.plotESButton -background "white" -text "PLOT ES" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {ENSCORE; set counter_ROD 1} -width 8
tooltip::tooltip $w.frame5.plotESButton "\
 Plot the energy score
 for every largest cluster"
pack $w.frame5.plotESButton -side left

button $w.frame5.plotNAButton -background "white" -text "PLOT NA" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {NA; set counter_ROD 0} -width 8
tooltip::tooltip $w.frame5.plotNAButton "\
 Plot the nearest residues
 for every largest cluster"
pack $w.frame5.plotNAButton -side left

entry $w.frame5.distanceNA -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable distanceNA -width 2 -justify right
set distanceNA "3"
tooltip::tooltip $w.frame5.distanceNA "\
 Plot NA threshold"
pack $w.frame5.distanceNA -side left

button $w.frame5.plotMCButton -background "white" -text "PLOT MC" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {MC; set counter_ROD 0} -width 8
tooltip::tooltip $w.frame5.plotMCButton "\
 Plot the position of the
 center-of-mass for 
 every largest cluster"
pack $w.frame5.plotMCButton -side left

button $w.frame5.spheresButton -background "white" -text "SHOW MC" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {BALL}
tooltip::tooltip $w.frame5.spheresButton "\
 Show the center-of-mass on screen"
pack $w.frame5.spheresButton -side left

frame $w.frame6 
pack $w.frame6 -padx 1 -fill x
radiobutton $w.frame6.secondchoice  -relief groove -width 18 -text "MD PACKAGE" -font {Helvetica -14} -variable MODALITY -value 1
pack $w.frame6.secondchoice -side left

frame $w.frame7
pack $w.frame7 -padx 1 -fill x 

button $w.frame7.coordinateButton -background "white" -text "Coordinate:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set COORD [tk_getOpenFile]} -width 15
tooltip::tooltip $w.frame7.coordinateButton "\
 Select the coordinate
 of your simulation."
pack $w.frame7.coordinateButton -side left

entry $w.frame7.coordinateEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable COORD -justify right
pack $w.frame7.coordinateEntry -side left -fill x

button $w.frame7.trajectoryButton -background "white" -text "Trajectory:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set TRAJ [tk_getOpenFile]} -width 15
tooltip::tooltip $w.frame7.trajectoryButton "\
 Select the trajectory
 of your simulation."
pack $w.frame7.trajectoryButton -side left

entry $w.frame7.trajectoryEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable TRAJ -justify right
pack $w.frame7.trajectoryEntry  -fill x

frame $w.frame7bis
pack $w.frame7bis -padx 1 -fill x

button $w.frame7bis.topReceptorButton -background "white" -text "Receptor topology:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set TOPRECEPTOR [tk_getOpenFile]} -width 15
tooltip::tooltip $w.frame7bis.topReceptorButton "\
 Select the topology
  of the receptor."
pack $w.frame7bis.topReceptorButton -side left

entry $w.frame7bis.topReceptorEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable TOPRECEPTOR -justify right
pack $w.frame7bis.topReceptorEntry -side left -fill x

button $w.frame7bis.topLigandButton -background "white" -text "Ligand topology:" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {set TOPLIGAND [tk_getOpenFile]} -width 15
tooltip::tooltip $w.frame7bis.topLigandButton "\
 Select the topology
   of the ligand."
pack $w.frame7bis.topLigandButton -side left

entry $w.frame7bis.topLigandEntry -background grey -foreground black -relief ridge -borderwidth 1 -font {Helvetica -18 bold} -textvariable TOPLIGAND -justify right
pack $w.frame7bis.topLigandEntry -fill x

frame $w.frame8
pack $w.frame8 -padx 1 -fill x

button $w.frame8.loadTJButton -background "white" -text "LOAD" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {LOAD2} -width 8
tooltip::tooltip $w.frame8.loadTJButton "\
 Upload the trajectory"
pack $w.frame8.loadTJButton -side left

button $w.frame8.fitButton -background "white" -text "FIT" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {FIT} -width 8
tooltip::tooltip $w.frame8.fitButton "\
 Fit the trajectory
 on the receptor atoms"
pack $w.frame8.fitButton -side left -fill x

message $w.frame8.messageTRAJ -background "white" -text " Trajectory analysis ->" -font {Helvetica -18 bold} -relief flat -borderwidth 3 -width 260
tooltip::tooltip $w.frame8.messageTRAJ "\
 Select the interval for
 the trajectory analysis"
pack $w.frame8.messageTRAJ -side left -padx 1.5

message $w.frame8.messageFrom -background "white" -text "FROM: " -font {Helvetica -16 bold} -relief flat -borderwidth 2 -width 60
pack $w.frame8.messageFrom -side left 

entry $w.frame8.entryFrom -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable entryfrom -width 2 -justify right -width 7
set entryfrom "first"
pack $w.frame8.entryFrom -side left -fill x

message $w.frame8.messageTo -background "white" -text "TO: " -font {Helvetica -16 bold} -relief flat -borderwidth 2
pack $w.frame8.messageTo -side left  -fill x

entry $w.frame8.entryTo -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable entryTo -width 2 -justify right -width 7
set entryTo "last"
pack $w.frame8.entryTo -side left -fill x

frame $w.frame8bis
pack $w.frame8bis -padx 1 -fill x

#message $w.frame8bis.spazietto -background "white" -text "           " -font {Helvetica -18 bold} -relief flat -borderwidth 3 -width 260
#pack $w.frame8bis.spazietto -side left -padx 1.5

button $w.frame8bis.clusterButton -background "white" -text "CLUSTER" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {CLUSTER} -width 8
tooltip::tooltip $w.frame8bis.clusterButton "\
 Cluster your trajectory"
pack $w.frame8bis.clusterButton -side left -fill x

entry $w.frame8bis.clusterCutoff -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable clCutoff -width 3 -justify right
set clCutoff "1.5"
pack $w.frame8bis.clusterCutoff -side left -fill x

button $w.frame8bis.saveCLButton -background "white" -text "PLOT ES" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {SAVECL} -width 8
tooltip::tooltip $w.frame8bis.saveCLButton "\
 Calculate the AD4 ES for each
 cluster families' centroid
 and plot the results"
pack $w.frame8bis.saveCLButton -side left -fill x

message $w.frame8bis.spazietto2 -background "white" -text "NBR.:" -font {Helvetica -16 bold} -relief flat -borderwidth 1 -width 250
tooltip::tooltip $w.frame8bis.spazietto2 "\
  Specify the neighbouring cutoff value in Å"
pack $w.frame8bis.spazietto2 -side left -fill x

entry $w.frame8bis.clusterLimit -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable clLimit -width 2 -justify right
set clLimit "10"
pack $w.frame8bis.clusterLimit -side left -fill x

message $w.frame8bis.spazietto -background "white" -text "TOR.:" -font {Helvetica -16 bold} -relief flat -borderwidth 1 -width 250
tooltip::tooltip $w.frame8bis.spazietto "\
  Specify the amount of ligand torsions"
pack $w.frame8bis.spazietto -side left -fill x

entry $w.frame8bis.clusterTorsion -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable clTorsion -width 2 -justify right
set clTorsion "0"
pack $w.frame8bis.clusterTorsion -side left -fill x

button $w.frame8bis.plotNAButton -background "white" -text "PLOT NA" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {NA; set counter_ROD 0} -width 8
tooltip::tooltip $w.frame8bis.plotNAButton "\
 Plot the nearest residues
 for your ligand during
 the simulation"
pack $w.frame8bis.plotNAButton -side left

entry $w.frame8bis.distanceNA -background "white" -foreground black  -font {Helvetica -18 bold} -textvariable distanceNA -width 2 -justify right
set distanceNA "3"
tooltip::tooltip $w.frame8bis.distanceNA "\
 Plot NA threshold"
pack $w.frame8bis.distanceNA -side left

button $w.frame8bis.plotMCButton -background "white" -text "PLOT MC" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {MC; set counter_ROD 0} -width 8
tooltip::tooltip $w.frame8bis.plotMCButton "\
 Plot the position of
 the center-of-mass
 during the simulation"
pack $w.frame8bis.plotMCButton -side left

button $w.frame8bis.spheresButton -background "white" -text "SHOW MC" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {BALLTJ}
tooltip::tooltip $w.frame8bis.spheresButton "\
 Show the center-of-mass on screen"
pack $w.frame8bis.spheresButton -side left

#frame $w.frame9
#pack $w.frame9 -padx 1 -fill x

#=====LEFT DOOR=====#

#frame $w.frame9.leftpanel -relief flat -bd 2
#pack $w.frame9.leftpanel -padx 1 -side left

#message $w.frame9.leftpanel.message3 -background "white" -text "Receptor visualization options" -font {Helvetica -14 bold} -relief flat -borderwidth 2 -width 260
#pack $w.frame9.leftpanel.message3 -fill x

#radiobutton $w.frame9.leftpanel.yp1  -relief groove -width 12 -text "Default" -font {Helvetica -14} -variable RADIO -value 0
#pack $w.frame9.leftpanel.yp1 -side left

#radiobutton $w.frame9.leftpanel.yp2  -relief groove -width 12 -text "Free-selection" -font {Helvetica -14} -variable RADIO -value 1
#pack $w.frame9.leftpanel.yp2 -side left

#entry $w.frame9.leftpanel.entry-yp2 -background grey -foreground black  -font {Helvetica -16} -textvariable entry-yp2 -width 10
#set entry-yp2 "Write Here"
#pack $w.frame9.leftpanel.entry-yp2 -side left

#======RIGHT DOOR======#

#frame $w.frame9.rightpanel -relief flat -bd 2
#pack $w.frame9.rightpanel -padx 1

#message $w.frame9.rightpanel.message3 -background "white" -text "Receptor type options" -font {Helvetica -14 bold} -relief flat -borderwidth 2 -width 260
#pack $w.frame9.rightpanel.message3 -fill x

#radiobutton $w.frame9.rightpanel.yp1  -relief groove -width 12 -text "Protein" -font {Helvetica -14} -variable RADIO2 -value 0
#pack $w.frame9.rightpanel.yp1 -side left

#radiobutton $w.frame9.rightpanel.yp2  -relief groove -width 12 -text "Nuclear acids" -font {Helvetica -14} -variable RADIO2 -value 1
#pack $w.frame9.rightpanel.yp2 -side left

#====CANVAS=====#

frame $w.frame10 -height 320 -width 780 -relief ridge -borderwidth 5
pack $w.frame10

canvas $w.frame10.picture -height 320 -width 780
pack $w.frame10.picture

#====BUTTONS UNDER CANVAS=====#

frame $w.frame11 -relief flat -bd 2
pack $w.frame11 -padx 1 -fill x

button $w.frame11.resetButton -background red -foreground white -text "RESET" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {END} -width 8
pack $w.frame11.resetButton -side left -fill x

button $w.frame11.printButton -background "white" -text "PRINT" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {POSTSCRIPT} -width 8
tooltip::tooltip $w.frame11.printButton "\
 Print the plot on screen
 using postscript format"
pack $w.frame11.printButton -side right

button $w.frame11.writeButton -background "white" -text "WRITE" -font {Helvetica -18 bold} -relief ridge -borderwidth 5 -command {WRITE} -width 8
tooltip::tooltip $w.frame11.writeButton "\
 Write on a .txt file
 the data on the screen"
pack $w.frame11.writeButton -side right

###the ending return allows to re-launch DDT###
  return $w
}

#====THE REAL PROGRAM=====#

proc EXTRACT {} {
variable w

if {[catch {set checkEXTRACT [glob *.dlg]}]} {
  tk_messageBox -message "There aren't .dlg inside the WD" -type ok -icon error
  return
}

set checkLOAD [$w.frame3.receptorEntry get]
if {$checkLOAD == ""} {
  tk_messageBox -message "Receptor .pdb field is empty" -type ok -icon error
  return
}

set receptor [split [$w.frame3.receptorEntry get] "/"]
set receptorNAME [lindex $receptor [expr [llength $receptor]-1]]

set PDBlist [glob *.pdb]
if {[lsearch $PDBlist $receptorNAME] == "-1"} {
  tk_messageBox -message "Invalid value in Receptor .pdb field" -type ok -icon error
  return
}

set text [open "DOCKING_RESULT" w]
close $text
set text [open "DOCKING_RESULT" a]
puts $text "#DLG_file    #LC   #ES"
close $text

#set receptor [split [$w.frame3.receptorEntry get] "/"]
#set receptorNAME [lindex $receptor [expr [llength $receptor]-1]]

foreach j [glob *.dlg] {
  set dlginesame [open $j]
  set auxdlg [read $dlginesame]
  close $dlginesame
  set dlgsplit [split $auxdlg "\n"]
  set auxiliary ""
  for {set x 0} {$x<[llength $dlgsplit]} {incr x} {
    if {[lindex [lindex $dlgsplit $x] 0] == "ATOM" || [lindex [lindex $dlgsplit $x] 0] == "USER"} {
      lappend auxiliary [lindex $dlgsplit $x]
    }
  }
#  puts $auxiliary
  set clusterFIND ""
  for {set x 0} {$x< [expr [llength $auxiliary]+1]} {incr x} {
    if {[lindex [lindex $auxiliary $x] 0] == "USER" && [lindex [lindex $auxiliary $x] 6] == "cluster"} {
      lappend clusterFIND "[lindex $auxiliary $x] - $x"
    }
  }
  set clusterMAX 0
  set clusterLINE ""
  for {set x 0} {$x< [expr [llength $clusterFIND]+1]} {incr x} {
    if {$clusterMAX < [lindex [lindex $clusterFIND $x] 8]} {
    set clusterMAX [lindex [lindex $clusterFIND $x] 8]
    set clusterLINE [lindex [lindex $clusterFIND $x] 10]
    set clusterSUCC [lindex [lindex $clusterFIND [expr $x+1]] 10]
    if {$clusterSUCC == ""} {
      set clusterSUCC 99999999
    }
    }
  }

  set almostdone [open "fatguy.pdb" w]
  close $almostdone
  set almostdone [open "fatguy.pdb" a]

  set mannaggia [open "superfatguy.pdb" w]
  close $mannaggia
  set mannaggia [open "superfatguy.pdb" a]

  for {set x 0} {$x< [expr [llength $auxiliary]+1]} {incr x} {
    if {$x>[expr $clusterLINE-1] && $x<[expr $clusterSUCC+1] && [lindex [lindex $auxiliary $x] 0] != "USER"} {
       puts $almostdone "[lindex $auxiliary $x]"
       puts $mannaggia "[format "%.2f" $clusterMAX] [lindex [lindex $auxiliary [expr $clusterLINE +4]] 7]"
    }
  }
  set title [lindex [lindex $auxiliary [expr $clusterLINE +17]] 3]
  set titleDEF [lindex [split $title "."] 0]

  close $almostdone
  close $mannaggia
  puts [exec cut -c-54 fatguy.pdb > fatguy2.pdb]
  puts [exec paste fatguy2.pdb superfatguy.pdb > evvai.pdb]
  
  set ultimoTEXT [open "$titleDEF-BC.pdb-$receptorNAME" w]
  close $ultimoTEXT
  set ultimoTEXT [open "$titleDEF-BC.pdb-$receptorNAME" a]
  set pd [open "evvai.pdb"]
  set PD [read $pd]
  close $pd
  puts $ultimoTEXT $PD
  close $ultimoTEXT 
  file delete fatguy.pdb 
  file delete fatguy2.pdb
  file delete superfatguy.pdb
  file delete evvai.pdb  
  set text [open "DOCKING_RESULT" a]
  puts $text "$titleDEF   [format "%.2f" $clusterMAX] [lindex [lindex $auxiliary [expr $clusterLINE +4]] 7]"
  close $text
}

foreach hh [glob *BC.pdb-$receptorNAME] {
 set lucci [open $receptorNAME]
 set cp9 [read $lucci]
 close $lucci
 set nico [open $hh a]
 puts $nico $cp9
 close $nico
}

tk_messageBox -message "Extraction completed" -type ok -icon info
}

proc L {} {

variable w
variable RADIO
variable RADIO2
global LOADEDmolVS

set checkLOAD [$w.frame3.receptorEntry get]
if {$checkLOAD == ""} {
  tk_messageBox -message "Receptor .pdb field is empty" -type ok -icon error
  return 
}

set receptor [split [$w.frame3.receptorEntry get] "/"]
set receptorNAME [lindex $receptor [expr [llength $receptor]-1]]

#set PDBlist [glob *.pdb]
#if {[lsearch $PDBlist $receptorNAME] == "-1"} {
#  tk_messageBox -message "Invalid value in Receptor .pdb field" -type ok -icon error
#  return
#}

set PDBlist2 [glob *-$receptorNAME]
if {$PDBlist2 == ""} {
  tk_messageBox -message "Invalid value in Receptor .pdb field" -type ok -icon error
  return
}

if {$RADIO < 1} {

set number 0
foreach i [glob *-$receptorNAME] {
  mol new $i
  set number [expr $number +1]
}

for {set x [expr [molinfo index 0]]} {$x<[expr [expr [molinfo index 0]+[molinfo num]]]} {incr x} {
mol addrep $x
mol modstyle 0 $x licorice
mol modselect 0 $x "resname [$w.frame1.entry4 get]"
mol modstyle 1 $x newcartoon
mol modcolor 1 $x structure
mol addrep $x
mol modstyle 2 $x licorice

if {$RADIO2 < 1} {
  mol modselect 2 $x "same residue as protein within 4 of resname [$w.frame1.entry4 get]"
} else {
  mol modselect 2 $x "same residue as nucleic within 4 of resname [$w.frame1.entry4 get]"
}

mol off $x
}
} else {
set number 0
foreach i [glob *-$receptorNAME] {
  mol new $i
  incr number
}

for {set x [expr [molinfo index 0]]} {$x<[expr [expr [molinfo index 0]+[molinfo num]]]} {incr x} {
mol addrep $x
mol modstyle 0 $x licorice
mol modselect 0 $x "resname [$w.frame1.entry4 get]"
mol modstyle 1 $x newcartoon
mol modcolor 1 $x structure
mol addrep $x
mol modstyle 2 $x licorice
mol modselect 2 $x "[$w.frame9.leftpanel.entry-yp2 get]"
mol off $x
}
}

puts "Press a to go on, q to go back"
mol on [molinfo index 0]
mol top [molinfo index 0]
set LOADEDmolVS [molinfo list]
#puts $LOADEDmolVS
}

user add key a {a}    #to bind a procedure to one of the keyboard's button
user add key q {q}

proc ::a {} {
variable w
variable counter_ROD
variable MODALITY
variable LOADEDmolVS
variable LOADEDmolMDtotal
$w.frame10.picture delete tracker

if {$MODALITY < 1} {
  set GUIARROWSlist $LOADEDmolVS
} else {
  set GUIARROWSlist $LOADEDmolMDtotal
} 

if {[llength [molinfo list]] > 35} {
#  set SPACE 7
  set SPACE [expr 730/[llength [molinfo list]]]
} else {
  set SPACE 20
}

set t [molinfo top]
mol off $t
if {$t == [lindex $GUIARROWSlist end]} {
  mol on $t
  set TRACKvalue [lsearch [molinfo list] [molinfo top]]
  if {$counter_ROD > 0} {
    $w.frame10.picture create line [expr (($TRACKvalue+1)*$SPACE)+45] 0 [expr (($TRACKvalue+1)*$SPACE)+45] 300 -tags tracker
  }
  puts "last molecule already displayed"
} else {
  set bookmark [lsearch $GUIARROWSlist $t]
  set l [lindex $GUIARROWSlist [expr $bookmark +1]]
#  set l [expr $t+1]
  mol on $l
  mol top $l
  set TRACKvalue [lsearch [molinfo list] [molinfo top]]
  if {$counter_ROD > 0} {
    $w.frame10.picture create line [expr (($TRACKvalue+1)*$SPACE)+45] 0 [expr (($TRACKvalue+1)*$SPACE)+45] 300 -tags tracker
  }
  puts "I'm showing the molecule [molinfo top]"
}

}


proc ::q {} {
variable w
variable counter_ROD
variable MODALITY
variable LOADEDmolVS
variable LOADEDmolMDtotal
$w.frame10.picture delete tracker

if {$MODALITY < 1} {
  set GUIARROWSlist $LOADEDmolVS
} else {
  set GUIARROWSlist $LOADEDmolMDtotal
}

if {[llength [molinfo list]] > 35} {
#  set SPACE 7
  set SPACE [expr 730/[llength [molinfo list]]]
} else {
  set SPACE 20
}

set t [molinfo top]
mol off $t
if {$t == [lindex $GUIARROWSlist 0]} {
  mol on $t
  set TRACKvalue [lsearch [molinfo list] [molinfo top]]
  if {$counter_ROD > 0} {
    $w.frame10.picture create line [expr (($TRACKvalue+1)*$SPACE)+45] 0 [expr (($TRACKvalue+1)*$SPACE)+45] 300 -tags tracker
  }
  puts "first molecule already displayed"
} else {
  set bookmark [lsearch $GUIARROWSlist $t]
  set d [lindex $GUIARROWSlist [expr $bookmark -1]]
  mol on $d
  mol top $d
  set TRACKvalue [lsearch [molinfo list] [molinfo top]]
  if {$counter_ROD > 0} {
    $w.frame10.picture create line [expr (($TRACKvalue+1)*$SPACE)+45] 0 [expr (($TRACKvalue+1)*$SPACE)+45] 300 -tags tracker
  }
  puts "I'm showing the molecule [molinfo top]"
}

}

proc END {} {
variable w

mol delete all
$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete linezCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

$w.frame10.picture delete tracker
set GRAPHICS 0
set linenumber 0
set counter_BALL 0
set counter_BOX 0
}

proc ENSCORE {} {
variable w
variable GRAPHICS
variable counter_ROD
variable ESlist

set GRAPHICS 1
set counter_ROD 1

$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete linezCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

set checkENSCORE [molinfo top]
if {$checkENSCORE == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkENSCORE2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkENSCORE2 [$checkENSCORE2aux get index]
if {$checkENSCORE2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

#=vertical axis=#
set spacey [expr 25]
$w.frame10.picture create line 45 0 45 300 -arrow last -tags linexES
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexES
$w.frame10.picture create text 32 293 -text "ES" -font {Times -13} -tags coordCM

#=horizontal axis=#
set spacex [expr 20]
$w.frame10.picture create line 35 15 770 15 -arrow last -tags lineyES


#=for the picture=#
set ymin 0
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
  if {$ymin > [lindex [$selecES get beta] 0]} {
     set ymin [lindex [$selecES get beta] 0]
  }
}
mol top $savepoint

set conversionY [expr 250/[expr -$ymin]]

set red 255
set colormax 0
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
  if {$colormax < [lindex [$selecES get occupancy] 0]} {
     set colormax [lindex [$selecES get occupancy] 0]
  }
}
mol top $savepoint


set colormin 9999999999
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
  if {$colormin > [lindex [$selecES get occupancy] 0]} {
     set colormin [lindex [$selecES get occupancy] 0]
  }
}
mol top $savepoint
set ESlist ""
set linenumber 0
set savepoint [molinfo top]
set howmanymolecules [llength [molinfo list]]
if {$howmanymolecules != 1} {
  foreach Molecule [molinfo list] {
    set ESaux ""
    mol top $Molecule
    set selecES [atomselect top "resname [$w.frame1.entry4 get]"]

    set LCscore [lindex [$selecES get occupancy] 0]

    set col_point [format "#%02x%02x%02x" [format "%.0f" [expr (200-(200*[expr $LCscore-$colormin])/($colormax - $colormin))]] [format "%.0f" [expr (255*[expr $LCscore-$colormin])/($colormax - $colormin)]]  [format "%.0f" [expr 150-(150*([expr $LCscore-$colormin])/($colormax - $colormin))]]]

    set x [incr $linenumber]
    if {[llength [molinfo list]] > 35} {
#      set spacex 7
      set spacex [expr 730/[llength [molinfo list]]]
    }
    set xauxi [expr ($x*$spacex)+45]

    set y [lindex [$selecES get beta] 0]
    set yperfect [expr (-($y*$conversionY))+15]
    lappend ESaux $x
    lappend ESaux [format "%.2f" $y]
    lappend ESlist $ESaux
    $w.frame10.picture create oval [expr $xauxi +3] [expr $yperfect +3] [expr $xauxi -3] [expr $yperfect -3] -fill $col_point -tags pointsES

    if {[llength [molinfo list]] > 35} {
       if {[expr ($x*5)] < [expr [llength [molinfo list]]+1] } {
         $w.frame10.picture create line [expr ($x*$spacex*5)+45] 10 [expr ($x*$spacex*5)+45] 15 -tags pointsES
       }
    } else {
      $w.frame10.picture create line $xauxi 10 $xauxi 15 -tags pointsES
    }
  }
} else {
    set ESaux ""
    set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
    set LCscore [lindex [$selecES get occupancy] 0]
    set x 1
    set xauxi [expr ($x*$spacex)+45]
    set y [lindex [$selecES get beta] 0]
    set yperfect [expr (-($y*$conversionY))+15]
    lappend ESaux $x
    lappend ESaux [format "%.2f" $y]
    lappend ESlist $ESaux
    $w.frame10.picture create oval [expr $xauxi +3] [expr $yperfect +3] [expr $xauxi -3] [expr $yperfect -3] -fill green -tags pointsES
    $w.frame10.picture create line $xauxi 10 $xauxi 15 -tags pointsES
}
mol top $savepoint

set stickY [expr (-$ymin)/5]

$w.frame10.picture create text 20 15 -text [format "%.2f" 0] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 215 -text [format "%.2f" [expr $ymin+$stickY]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 165 -text [format "%.2f" [expr $ymin+[expr $stickY*2]]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 115 -text [format "%.2f" [expr $ymin+[expr $stickY*3]]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 65 -text [format "%.2f" [expr $ymin+[expr $stickY*4]]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 265 -text [format "%.2f" $ymin] -font {Helvetica -9} -tags coordES

$w.frame10.picture create rectangle 650 288 660 305 -fill [format "#%02x%02x%02x" 200 0 150] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 660 288 670 305 -fill [format "#%02x%02x%02x" 180 52 135] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 670 288 680 305 -fill [format "#%02x%02x%02x" 160 75 120] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 680 288 690 305 -fill [format "#%02x%02x%02x" 140 97 105] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 690 288 700 305 -fill [format "#%02x%02x%02x" 120 120 90] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 700 288 710 305 -fill [format "#%02x%02x%02x" 100 142 75] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 710 288 720 305 -fill [format "#%02x%02x%02x" 80 165 60] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 720 288 730 305 -fill [format "#%02x%02x%02x" 60 187 45] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 730 288 740 305 -fill [format "#%02x%02x%02x" 40 210 30] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 740 288 750 305 -fill [format "#%02x%02x%02x" 20 232 15] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 750 288 760 305 -fill green -tags pointsLC -outline ""
$w.frame10.picture create text 650 310 -text [format "%.2f" $colormin] -font {Helvetica -9} -tags pointsLC
$w.frame10.picture create text 760 310 -text [format "%.2f" $colormax] -font {Helvetica -9} -tags pointsLC

}

proc LCSCORE {} {
variable w
variable GRAPHICS
variable counter_ROD
variable LClist

set GRAPHICS 2
set counter_ROD 1

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete linezCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

set checkLCSCORE [molinfo top]
if {$checkLCSCORE == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkLCSCORE2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkLCSCORE2 [$checkLCSCORE2aux get index]
if {$checkLCSCORE2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

#=vertical axis=#
set spacey [expr 25]
$w.frame10.picture create line 45 10 45 300 -arrow first -tags linexLC
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexLC
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexLC
$w.frame10.picture create text 32 18 -text "LC" -font {Times -13} -tags coordCM

#=horizontal axis=#
set spacex [expr 20]
$w.frame10.picture create line 35 290 770 290 -arrow last -tags lineyLC



#=for the picture=#
set ymax 0
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
  if {$ymax < [lindex [$selecES get occupancy] 0]} {
     set ymax [lindex [$selecES get occupancy] 0]
  }
}
mol top $savepoint

set conversionY [expr 250/$ymax]

set red 255
set colormin -100
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
  if {$colormin < [lindex [$selecES get beta] 0]} {
     set colormin [lindex [$selecES get beta] 0]
  }
}
mol top $savepoint


set colormax 0
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
  if {$colormax > [lindex [$selecES get beta] 0]} {
     set colormax [lindex [$selecES get beta] 0]
  }
}
mol top $savepoint

set LClist ""
set linenumber 0
set savepoint [molinfo top]
set howmanymolecules [llength [molinfo list]]
if {$howmanymolecules != 1} {
  foreach Molecule [molinfo list] {
    set LCaux ""
    mol top $Molecule
    set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
    set x [incr $linenumber]
    if {[llength [molinfo list]] > 35} {
#      set spacex 7
       set spacex [expr 730/[llength [molinfo list]]]
    }
    set xauxi [expr ($x*$spacex)+45]
    set y [expr [lindex [$selecES get occupancy] 0]*$conversionY]
    lappend LCaux $x
    lappend LCaux [format "%.2f" [lindex [$selecES get occupancy] 0]]
    lappend LClist $LCaux
    set yperfect [expr 290-$y]
    set ESscore [lindex [$selecES get beta] 0]

    set col_point [format "#%02x%02x%02x" [format "%.0f" [expr (30+(225*[expr $ESscore-$colormin])/($colormax - $colormin))]] [format "%.0f" [expr (144-(144*[expr $ESscore-$colormin])/($colormax - $colormin))]] [expr 255- [format "%.0f" [expr (255*[expr $ESscore-$colormin])/($colormax - $colormin)]]]]

    $w.frame10.picture create oval [expr $xauxi +3] [expr $yperfect +3] [expr $xauxi -3] [expr $yperfect -3] -fill $col_point -tags pointsLC
    if {[llength [molinfo list]] > 35} {
      if {[expr ($x*5)] < [expr [llength [molinfo list]]+1] } {
        $w.frame10.picture create line [expr ($x*$spacex*5)+45] 295 [expr ($x*$spacex*5)+45] 290 -tags pointsLC
        $w.frame10.picture create text [expr ($x*$spacex*5)+45] 308 -text [expr ($x*5) ] -font {Helvetica -9} -tags coordLC
      }
    } else {
      $w.frame10.picture create line $xauxi 295 $xauxi 290 -tags pointsLC
      $w.frame10.picture create text $xauxi 308 -text $x -font {Helvetica -9} -tags coordLC
    }
  }
} else {
    set LCaux ""
    set selecES [atomselect top "resname [$w.frame1.entry4 get]"]
    set LCscore [lindex [$selecES get beta] 0]
    set x 1
    set xauxi [expr ($x*$spacex)+45]
    set y [expr [lindex [$selecES get occupancy] 0]*$conversionY]
    set yperfect [expr 290-$y]
    lappend LCaux $x
    lappend LCaux [format "%.2f" [lindex [$selecES get occupancy] 0]]
    lappend LClist $LCaux
    $w.frame10.picture create oval [expr $xauxi +3] [expr $yperfect +3] [expr $xauxi -3] [expr $yperfect -3] -fill red -tags pointsLC
    $w.frame10.picture create line $xauxi 295 $xauxi 290 -tags pointsLC
    $w.frame10.picture create text $xauxi 308 -text $x -font {Helvetica -9} -tags coordLC
}
mol top $savepoint
set stickY [expr $ymax/5.0]

$w.frame10.picture create text 20 40 -text [format "%.2f" $ymax] -font {Helvetica -9} -tags coordLC
$w.frame10.picture create text 20 240 -text [format "%.2f" [expr $stickY]] -font {Helvetica -9} -tags coordLC
$w.frame10.picture create text 20 190 -text [format "%.2f" [expr $stickY*2]] -font {Helvetica -9} -tags coordLC
$w.frame10.picture create text 20 140 -text [format "%.2f" [expr $stickY*3]] -font {Helvetica -9} -tags coordLC
$w.frame10.picture create text 20 90 -text [format "%.2f" [expr $stickY*4]] -font {Helvetica -9} -tags coordLC
$w.frame10.picture create text 20 290 -text [format "%.2f" 0] -font {Helvetica -9} -tags coordLC

$w.frame10.picture create rectangle 650 8 660 25 -fill [format "#%02x%02x%02x" 30 144 255] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 660 8 670 25 -fill [format "#%02x%02x%02x" 52 130 229] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 670 8 680 25 -fill [format "#%02x%02x%02x" 75 115 204] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 680 8 690 25 -fill [format "#%02x%02x%02x" 97 101 178] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 690 8 700 25 -fill [format "#%02x%02x%02x" 120 86 153] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 700 8 710 25 -fill [format "#%02x%02x%02x" 142 72 127] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 710 8 720 25 -fill [format "#%02x%02x%02x" 165 58 102] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 720 8 730 25 -fill [format "#%02x%02x%02x" 187 43 76] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 730 8 740 25 -fill [format "#%02x%02x%02x" 210 29 51] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 740 8 750 25 -fill [format "#%02x%02x%02x" 232 14 26] -tags pointsLC -outline ""
$w.frame10.picture create rectangle 750 8 760 25 -fill red -tags pointsLC -outline ""
$w.frame10.picture create text 650 30 -text [format "%.2f" $colormin] -font {Helvetica -9} -tags pointsLC
$w.frame10.picture create text 760 30 -text [format "%.2f" $colormax] -font {Helvetica -9} -tags pointsLC

}

proc BOX {} {

variable w
variable counter_BOX

set checkBOX [molinfo top]
if {$checkBOX == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkBOX2 [$w.frame3.gpfEntry get]
if {$checkBOX2 == ""} {
  tk_messageBox -message "No .gpf loaded" -type ok -icon error
  return
}

if {[catch {open [$w.frame3.gpfEntry get]}]} {
  tk_messageBox -message "Invalid .gpf value" -type ok -icon error
  return
}

if {$counter_BOX < 1} {
  set counter_BOX [expr $counter_BOX +1]
  set savepoint [molinfo top]
  foreach Molecule [molinfo list] {
    mol top $Molecule
    set gpf [open [$w.frame3.gpfEntry get]]
    set TEXTgpf [read $gpf]
    close $gpf
    set lines [split $TEXTgpf "\n"]
    set pointsX [lindex [lindex $lines 0] 1]
    set pointsY [lindex [lindex $lines 0] 2]
    set pointsZ [lindex [lindex $lines 0] 3]

    set spacing [lindex [lindex $lines 2] 1]

    set assex [expr ($pointsX*$spacing)/2]
    set assey [expr ($pointsY*$spacing)/2]
    set assez [expr ($pointsZ*$spacing)/2]

    set centerX [lindex [lindex $lines 6] 1]
    set centerY [lindex [lindex $lines 6] 2]
    set centerZ [lindex [lindex $lines 6] 3]

    set xmax [expr $centerX+$assex]
    set xmin [expr $centerX-$assex]

    set ymax [expr $centerY+$assey]
    set ymin [expr $centerY-$assey]

    set zmax [expr $centerZ+$assez]
    set zmin [expr $centerZ-$assez]

    set point1 "$xmax $ymin $zmin"
    set point2 "$xmax $ymax $zmin"
    set point3 "$xmax $ymin $zmax"
    set point4 "$xmax $ymax $zmax"
    set point5 "$xmin $ymin $zmin"
    set point6 "$xmin $ymax $zmin"
    set point7 "$xmin $ymin $zmax"
    set point8 "$xmin $ymax $zmax"

    draw color orange2
    draw line $point1 $point2 width 3
    draw line $point3 $point4 width 3
    draw line $point1 $point3 width 3
    draw line $point2 $point4 width 3
    draw line $point5 $point6 width 3
    draw line $point7 $point8 width 3
    draw line $point5 $point7 width 3
    draw line $point6 $point8 width 3
    draw line $point1 $point5 width 3
    draw line $point2 $point6 width 3
    draw line $point3 $point7 width 3
    draw line $point4 $point8 width 3
  }
  mol top $savepoint
} else {
  set counter_BOX 0
  set savepoint [molinfo top]
  foreach Molecule [molinfo list] {
    mol top $Molecule
    draw delete all
  }
  mol top $savepoint
}
}

proc MC {} {

variable w
variable GRAPHICS
variable MODALITY
variable counter_ROD
variable MClist

set GRAPHICS 4
set counter_ROD 0

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete tracker

set checkMC [molinfo top]
if {$checkMC == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

if {$MODALITY < 1} {

set savepoint [molinfo top]

set checkMCaux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkMC [$checkMCaux get index]
if {$checkMC == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

set border [atomselect top "all"]
set minassex [lindex [lindex [measure minmax $border] 0] 0]
set minassey [lindex [lindex [measure minmax $border] 0] 1]
set minassez [lindex [lindex [measure minmax $border] 0] 2]

set maxassex [lindex [lindex [measure minmax $border] 1] 0]
set maxassey [lindex [lindex [measure minmax $border] 1] 1]
set maxassez [lindex [lindex [measure minmax $border] 1] 2]

set lunghezzax [expr $maxassex - $minassex]
set lunghezzay [expr $maxassey - $minassey]
set lunghezzaz [expr $maxassez - $minassez]

set stickX [expr $lunghezzax/5]
set stickY [expr $lunghezzay/5]
set stickZ [expr $lunghezzaz/5]

set conversionX [expr 300/$lunghezzax]
set conversionY [expr 250/$lunghezzay]
set conversionZ [expr 300/$lunghezzaz]

$w.frame10.picture create text 45 308 -text [format "%.2f" $minassex] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 105 308 -text [format "%.2f" [expr $minassex+$stickX]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 165 308 -text [format "%.2f" [expr $minassex+[expr $stickX*2]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 225 308 -text [format "%.2f" [expr $minassex+[expr $stickX*3]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 285 308 -text [format "%.2f" [expr $minassex+[expr $stickX*4]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 345 308 -text [format "%.2f" $maxassex] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 387 304 -text "X" -font {Times -13} -tags coordCM

$w.frame10.picture create text 20 290 -text [format "%.2f" $minassey] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 240 -text [format "%.2f" [expr $minassey+$stickY]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 190 -text [format "%.2f" [expr $minassey+[expr $stickY*2]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 140 -text [format "%.2f" [expr $minassey+[expr $stickY*3]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 90 -text [format "%.2f" [expr $minassey+[expr $stickY*4]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 40 -text [format "%.2f" $maxassey] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 33 18 -text "Y" -font {Times -13} -tags coordCM
$w.frame10.picture create text 403 18 -text "Y" -font {Times -13} -tags coordCM

$w.frame10.picture create text 415 308 -text [format "%.2f" $minassez] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 475 308 -text [format "%.2f" [expr $minassez+$stickZ]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 535 308 -text [format "%.2f" [expr $minassez+[expr $stickZ*2]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 595 308 -text [format "%.2f" [expr $minassez+[expr $stickZ*3]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 655 308 -text [format "%.2f" [expr $minassez+[expr $stickZ*4]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 715 308 -text [format "%.2f" $maxassez] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 763 304 -text "Z" -font {Times -13} -tags coordCM

#set fp [open "MC.pdb" w]
#close $fp
#set fp [open "MC.pdb" a]
#puts $fp "CENTER OF MASS DISTRIBUTION"
#close $fp

set MClist ""
foreach Molecule [molinfo list] {
  set MCaux ""
  mol top $Molecule
  set ligand [atomselect top "resname [$w.frame1.entry4 get]"]
  set xmass [expr [expr [expr [lindex [measure center $ligand] 0]-$minassex]*$conversionX]+45]
  set ymass [expr 290-[expr [expr [lindex [measure center $ligand] 1]-$minassey]*$conversionY]]
  set zmass [expr [expr [expr [lindex [measure center $ligand] 2]-$minassez]*$conversionZ]+415]

  lappend MCaux [lindex [measure center $ligand] 0]
  lappend MCaux [lindex [measure center $ligand] 1]
  lappend MCaux [lindex [measure center $ligand] 2]
  lappend MClist $MCaux

  $w.frame10.picture create oval [expr $xmass-3] [expr $ymass-3] [expr $xmass+3] [expr $ymass+3] -fill pink -tags pointsCM
  $w.frame10.picture create oval [expr $zmass-3] [expr $ymass-3] [expr $zmass+3] [expr $ymass+3] -fill cyan -tags pointsCM

#  set fp [open "MC.pdb" a]
#  puts $fp "ATOM      $Molecule  C   DUM     1      [format "%.3f" [lindex [measure center $ligand] 0]]   [format "%.3f" [lindex [measure center $ligand] 1]]   [format "%.3f" [lindex [measure center $ligand] 2]]  0.00  0.00"
#  close $fp

}


#=horizontal axis1=#
set spacex [expr 30]
$w.frame10.picture create line 35 290 395 290 -arrow last -tags lineyCM
$w.frame10.picture create line [expr $spacex +45] 295 [expr $spacex +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*2 +45] 295 [expr $spacex*2 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*3 +45] 295 [expr $spacex*3 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*4 +45] 295 [expr $spacex*4 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*5 +45] 295 [expr $spacex*5 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*6 +45] 295 [expr $spacex*6 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*7 +45] 295 [expr $spacex*7 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*8 +45] 295 [expr $spacex*8 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*9 +45] 295 [expr $spacex*9 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*10 +45] 295 [expr $spacex*10 +45] 290 -tags lineyCM

#=horizontal axis2=#
set spacex [expr 30]
$w.frame10.picture create line 405 290 770 290 -arrow last -tags lineyCM
$w.frame10.picture create line [expr $spacex +415] 295 [expr $spacex +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*2 +415] 295 [expr $spacex*2 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*3 +415] 295 [expr $spacex*3 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*4 +415] 295 [expr $spacex*4 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*5 +415] 295 [expr $spacex*5 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*6 +415] 295 [expr $spacex*6 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*7 +415] 295 [expr $spacex*7 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*8 +415] 295 [expr $spacex*8 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*9 +415] 295 [expr $spacex*9 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*10 +415] 295 [expr $spacex*10 +415] 290 -tags lineyCM



#=vertical axis1=#
set spacey [expr 25]
$w.frame10.picture create line 45 10 45 300 -arrow first -tags linexCM
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexCM

#=vertical axis1=#
set spacey [expr 25]
$w.frame10.picture create line 415 10 415 300 -arrow first -tags linexCM
$w.frame10.picture create line 410 [expr $spacey +15] 415 [expr $spacey +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*2 +15] 415 [expr $spacey*2 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*3 +15] 415 [expr $spacey*3 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*4 +15] 415 [expr $spacey*4 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*5 +15] 415 [expr $spacey*5 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*6 +15] 415 [expr $spacey*6 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*7 +15] 415 [expr $spacey*7 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*8 +15] 415 [expr $spacey*8 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*9 +15] 415 [expr $spacey*9 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*10 +15] 415 [expr $spacey*10 +15] -tags linexCM

mol top $savepoint

} else {

set checkFROM [$w.frame8.entryFrom get]
if {[string is integer $checkFROM] == 0} {
  tk_messageBox -message "Invalid value in FROM field" -type ok -icon error
  return
}

set checkTO [$w.frame8.entryTo get]
if {[string is integer $checkTO] == 0} {
  tk_messageBox -message "Invalid value in TO field" -type ok -icon error
  return
}

if {[$w.frame8.entryTo get] < [$w.frame8.entryFrom get]} {
  tk_messageBox -message "The selected time interval is nonsense" -type ok -icon error
  return
}

set checkMCaux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkMC [$checkMCaux get index]
if {$checkMC == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

set nframe [molinfo top get numframes]
set minassex 999999
set minassey 999999
set minassez 999999
set maxassex -999999
set maxassey -999999
set maxassez -999999

for {set x 0} {$x<= $nframe} {incr x} {
  set border [atomselect top "all" frame $x]
  if {$minassex > [expr [lindex [lindex [measure minmax $border] 0] 0]]} {
    set minassex [lindex [lindex [measure minmax $border] 0] 0]
  }
  if {$minassey > [expr [lindex [lindex [measure minmax $border] 0] 1]]} {
    set minassey [lindex [lindex [measure minmax $border] 0] 1]
  }
  if {$minassez > [expr [lindex [lindex [measure minmax $border] 0] 2]]} {
    set minassez [lindex [lindex [measure minmax $border] 0] 2]
  }
  if {$maxassex < [expr [lindex [lindex [measure minmax $border] 1] 0]]} {
    set maxassex [lindex [lindex [measure minmax $border] 1] 0]
  }
  if {$maxassey < [expr [lindex [lindex [measure minmax $border] 1] 1]]} {
    set maxassey [lindex [lindex [measure minmax $border] 1] 1]
  }
  if {$maxassez < [expr [lindex [lindex [measure minmax $border] 1] 2]]} {
    set maxassez [lindex [lindex [measure minmax $border] 1] 2]
  }
}


set lunghezzax [expr $maxassex - $minassex]
set lunghezzay [expr $maxassey - $minassey]
set lunghezzaz [expr $maxassez - $minassez]

set stickX [expr $lunghezzax/5]
set stickY [expr $lunghezzay/5]
set stickZ [expr $lunghezzaz/5]

set conversionX [expr 300/$lunghezzax]
set conversionY [expr 250/$lunghezzay]
set conversionZ [expr 300/$lunghezzaz]

$w.frame10.picture create text 45 308 -text [format "%.2f" $minassex] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 105 308 -text [format "%.2f" [expr $minassex+$stickX]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 165 308 -text [format "%.2f" [expr $minassex+[expr $stickX*2]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 225 308 -text [format "%.2f" [expr $minassex+[expr $stickX*3]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 285 308 -text [format "%.2f" [expr $minassex+[expr $stickX*4]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 345 308 -text [format "%.2f" $maxassex] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 387 304 -text "X" -font {Times -13} -tags coordCM

$w.frame10.picture create text 20 290 -text [format "%.2f" $minassey] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 240 -text [format "%.2f" [expr $minassey+$stickY]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 190 -text [format "%.2f" [expr $minassey+[expr $stickY*2]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 140 -text [format "%.2f" [expr $minassey+[expr $stickY*3]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 90 -text [format "%.2f" [expr $minassey+[expr $stickY*4]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 20 40 -text [format "%.2f" $maxassey] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 33 18 -text "Y" -font {Times -13} -tags coordCM
$w.frame10.picture create text 403 18 -text "Y" -font {Times -13} -tags coordCM

$w.frame10.picture create text 415 308 -text [format "%.2f" $minassez] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 475 308 -text [format "%.2f" [expr $minassez+$stickZ]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 535 308 -text [format "%.2f" [expr $minassez+[expr $stickZ*2]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 595 308 -text [format "%.2f" [expr $minassez+[expr $stickZ*3]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 655 308 -text [format "%.2f" [expr $minassez+[expr $stickZ*4]]] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 715 308 -text [format "%.2f" $maxassez] -font {Helvetica -9} -tags coordCM
$w.frame10.picture create text 763 304 -text "Z" -font {Times -13} -tags coordCM


#set fp [open "MC-trajectory.pdb" w]
#close $fp
#set fp [open "MC-trajectory.pdb" a]
#puts $fp "CENTER OF MASS DISTRIBUTION"
#close $fp

set MClist ""
for {set x [$w.frame8.entryFrom get]} {$x<[expr [$w.frame8.entryTo get]+1]} {incr x} {
  set MCaux ""
  set ligand [atomselect top "resname [$w.frame1.entry4 get]" frame $x]
  set xmass [expr [expr [expr [lindex [measure center $ligand] 0]-$minassex]*$conversionX]+45]
  set ymass [expr 290-[expr [expr [lindex [measure center $ligand] 1]-$minassey]*$conversionY]]
  set zmass [expr [expr [expr [lindex [measure center $ligand] 2]-$minassez]*$conversionZ]+415]

  lappend MCaux [lindex [measure center $ligand] 0]
  lappend MCaux [lindex [measure center $ligand] 1]
  lappend MCaux [lindex [measure center $ligand] 2]
  lappend MClist $MCaux

  $w.frame10.picture create oval [expr $xmass-3] [expr $ymass-3] [expr $xmass+3] [expr $ymass+3] -fill gold -tags pointsCM
  $w.frame10.picture create oval [expr $zmass-3] [expr $ymass-3] [expr $zmass+3] [expr $ymass+3] -fill {medium spring green} -tags pointsCM

#set fp [open "MC-trajectory.pdb" a]
#  puts $fp "ATOM      1  C   DUM     1      [format "%.3f" [lindex [measure center $ligand] 0]]   [format "%.3f" [lindex [measure center $ligand] 1]]   [format "%.3f" [lindex [measure center $ligand] 2]]  0.00  0.00"
#  close $fp

}

#=horizontal axis1=#
set spacex [expr 30]
$w.frame10.picture create line 35 290 395 290 -arrow last -tags lineyCM
$w.frame10.picture create line [expr $spacex +45] 295 [expr $spacex +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*2 +45] 295 [expr $spacex*2 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*3 +45] 295 [expr $spacex*3 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*4 +45] 295 [expr $spacex*4 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*5 +45] 295 [expr $spacex*5 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*6 +45] 295 [expr $spacex*6 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*7 +45] 295 [expr $spacex*7 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*8 +45] 295 [expr $spacex*8 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*9 +45] 295 [expr $spacex*9 +45] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*10 +45] 295 [expr $spacex*10 +45] 290 -tags lineyCM

#=horizontal axis2=#
set spacex [expr 30]
$w.frame10.picture create line 405 290 770 290 -arrow last -tags lineyCM
$w.frame10.picture create line [expr $spacex +415] 295 [expr $spacex +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*2 +415] 295 [expr $spacex*2 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*3 +415] 295 [expr $spacex*3 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*4 +415] 295 [expr $spacex*4 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*5 +415] 295 [expr $spacex*5 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*6 +415] 295 [expr $spacex*6 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*7 +415] 295 [expr $spacex*7 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*8 +415] 295 [expr $spacex*8 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*9 +415] 295 [expr $spacex*9 +415] 290 -tags lineyCM
$w.frame10.picture create line [expr $spacex*10 +415] 295 [expr $spacex*10 +415] 290 -tags lineyCM

#=vertical axis1=#
set spacey [expr 25]
$w.frame10.picture create line 45 10 45 300 -arrow first -tags linexCM
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexCM
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexCM

#=vertical axis1=#
set spacey [expr 25]
$w.frame10.picture create line 415 10 415 300 -arrow first -tags linexCM
$w.frame10.picture create line 410 [expr $spacey +15] 415 [expr $spacey +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*2 +15] 415 [expr $spacey*2 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*3 +15] 415 [expr $spacey*3 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*4 +15] 415 [expr $spacey*4 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*5 +15] 415 [expr $spacey*5 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*6 +15] 415 [expr $spacey*6 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*7 +15] 415 [expr $spacey*7 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*8 +15] 415 [expr $spacey*8 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*9 +15] 415 [expr $spacey*9 +15] -tags linexCM
$w.frame10.picture create line 410 [expr $spacey*10 +15] 415 [expr $spacey*10 +15] -tags linexCM

}
}

proc NA {} {

variable w
variable GRAPHICS
variable MODALITY
variable counter_ROD
variable RADIO2
variable NAlist

set GRAPHICS 3
set counter_ROD 0

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete linezCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

$w.frame10.picture delete tracker

set checkNA [molinfo top]
if {$checkNA == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

if {[string is double [$w.frame5.distanceNA get]] == 0 || [$w.frame5.distanceNA get] < 0 || [$w.frame5.distanceNA get] == "-0"} {
  tk_messageBox -message "Error in PLOT NA treshold" -type ok -icon error
  return
}

set checkNA2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkNA2 [$checkNA2aux get index]
if {$checkNA2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

if {$MODALITY < 1} {

set savepoint [molinfo top]
set fp [open "NEAREST_AMINO_ACIDS.txt" w]
close $fp
set fp [open "NEAREST_AMINO_ACIDS.txt" a]
puts $fp "NEAREST AMINO ACIDS"
close $fp


set pdb_max 0
set pdb_min 9999
foreach Molecule [molinfo list] {
  mol top $Molecule
  if {$RADIO2 < 1} {
    set Outline [atomselect top "(same residue as protein within [$w.frame5.distanceNA get] of resname [$w.frame1.entry4 get]) and name CA"]
  } else {
    set Outline [atomselect top "(same residue as nucleic within [$w.frame5.distanceNA get] of resname [$w.frame1.entry4 get]) and name P"]
  }
  if {[lindex [$Outline get resid] 0]!= ""} {
  if {$pdb_max < [lindex [$Outline get resid] end]} {
     set pdb_max [lindex [$Outline get resid] end]
  }
  if {$pdb_min > [lindex [$Outline get resid] 0]} {
     set pdb_min [lindex [$Outline get resid] 0]
  }
  }
  set fp [open "NEAREST_AMINO_ACIDS.txt" a]
  puts $fp [$Outline get resid]
  close $fp
}

set aux [open NEAREST_AMINO_ACIDS.txt]
set text [read $aux]
close $aux
set ymax 0
for {set p $pdb_min} {$p<[expr $pdb_max +1]} {incr p} {
    set paux "\\m$p\\M" 
    if {$ymax < [expr [llength [regexp -inline -all $paux $text]]]} {
    set ymax [expr [llength [regexp -inline -all $paux $text]]]
}
}
set stickY [expr $ymax.0/5]

$w.frame10.picture create text 20 40 -text [format "%.2f" $ymax] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 240 -text [format "%.2f" [expr $stickY]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 190 -text [format "%.2f" [expr $stickY*2]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 140 -text [format "%.2f" [expr $stickY*3]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 90 -text [format "%.2f" [expr $ymax-$stickY]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 290 -text [format "%.2f" 0] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 32 18 -text "NA" -font {Times -13} -tags coordCM

if {$ymax == 0} {
  set conversionY 1
} else { 
  set conversionY [expr 250/$ymax]
}

set NAlist ""

set aux [open NEAREST_AMINO_ACIDS.txt]
set text [read $aux]
close $aux
set counter 0
for {set p $pdb_min} {$p<[expr $pdb_max +1]} {incr p} {
  set NAaux ""
  set paux "\\m$p\\M"
  if {[llength [regexp -inline -all $paux $text]] != 0} {
   incr counter
   set x [expr ($counter*20)+45]

   set y [expr [llength [regexp -inline -all $paux $text]]]
   set yperfect [expr 290-($y*$conversionY)]
   set y2 [expr 290]
   lappend NAaux $p
   lappend NAaux $y
   lappend NAlist $NAaux

   set xrct [expr $x-7]
   set xrct2 [expr $x+7]


   $w.frame10.picture create rectangle $xrct $yperfect $xrct2 $y2 -fill blue -tags pointsNA
   $w.frame10.picture create text $x 308 -text $p -font {Helvetica -9} -tags coordNA
   $w.frame10.picture create line [expr $counter*20 +45] 295 [expr $counter*20 +45] 290 -tags pointsNA

  }
}

#=vertical axis=#
set spacey [expr 25]
$w.frame10.picture create line 45 10 45 300 -arrow first -tags linexNA
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexNA

#=horizontal axis=#
set spacex [expr 20]
$w.frame10.picture create line 45 290 770 290 -arrow last -tags lineyNA

mol top $savepoint
file delete NEAREST_AMINO_ACIDS.txt

} else {

set checkFROM [$w.frame8.entryFrom get]
if {[string is integer $checkFROM] == 0} {
  tk_messageBox -message "Invalid value in FROM field" -type ok -icon error
  return
}

set checkTO [$w.frame8.entryTo get]
if {[string is integer $checkTO] == 0} {
  tk_messageBox -message "Invalid value in TO field" -type ok -icon error
  return
}

if {[$w.frame8.entryTo get] < [$w.frame8.entryFrom get]} {
  tk_messageBox -message "The selected time interval is nonsense" -type ok -icon error
  return
}

set fp [open "NEAREST_AMINO_ACIDS-trajectory.txt" w]
close $fp
set fp [open "NEAREST_AMINO_ACIDS-trajectory.txt" a]
puts $fp "NEAREST AMINO ACIDS"
close $fp

set pdb_max 0
set pdb_min 99999

for {set frameNA [expr [$w.frame8.entryFrom get]+1]} {$frameNA<[expr [$w.frame8.entryTo get]+1]} {incr frameNA} {
  if {$RADIO2 < 1} {
    set Outline [atomselect top "(same residue as protein within [$w.frame8bis.distanceNA get] of resname [$w.frame1.entry4 get]) and name CA" frame $frameNA]
  } else {
    set Outline [atomselect top "(same residue as nucleic within [$w.frame8bis.distanceNA get] of resname [$w.frame1.entry4 get]) and name P" frame $frameNA]
  }
  if {[lindex [$Outline get resid] 0]!=""} {
  if {$pdb_max < [lindex [$Outline get resid] end]} {
     set pdb_max [lindex [$Outline get resid] end]
  }
  if {$pdb_min > [lindex [$Outline get resid] 0]} {
       set pdb_min [lindex [$Outline get resid] 0]
  }
  }
  set fp [open "NEAREST_AMINO_ACIDS-trajectory.txt" a]
  if {[$Outline get resid]!=""} {
    puts $fp [$Outline get resid]
    close $fp
  }
}
#puts $pdb_min
#puts $pdb_max

set ymin [$w.frame8.entryFrom get]
set ymax [$w.frame8.entryTo get]
set stickY [expr ($ymax.0 - $ymin.0)/5]

$w.frame10.picture create text 20 40 -text [format "%.2f" [expr $ymax-$ymin]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 240 -text [format "%.2f" [expr $stickY]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 190 -text [format "%.2f" [expr $stickY*2]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 140 -text [format "%.2f" [expr $stickY*3]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 90 -text [format "%.2f" [expr $stickY*4]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 290 -text [format "%.2f" 0] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 32 18 -text "NA" -font {Times -13} -tags coordCM


set conversionY [expr 250/($ymax.0 - $ymin.0)]

set NAlist ""

set aux [open NEAREST_AMINO_ACIDS-trajectory.txt]
set text [read $aux]
close $aux
set counter 0
for {set p $pdb_min} {$p<[expr $pdb_max +1]} {incr p} {
  set NAaux ""
  set paux "\\m$p\\M"
  if {[llength [regexp -inline -all $paux $text]] != 0} {
   incr counter
   set x [expr ($counter*20)+45]

   set y [expr [llength [regexp -inline -all $paux $text]]]
   set yperfect [expr 290-($y*$conversionY)]
   set y2 [expr 290]

   lappend NAaux $p
   lappend NAaux $y
   lappend NAlist $NAaux

   set xrct [expr $x-7]
   set xrct2 [expr $x+7]


   $w.frame10.picture create rectangle $xrct $yperfect $xrct2 $y2 -fill {sea green} -tags pointsNA
   $w.frame10.picture create text $x 308 -text $p -font {Helvetica -9} -tags coordNA
   $w.frame10.picture create line [expr $counter*20 +45] 295 [expr $counter*20 +45] 290 -tags pointsNA

  }
}


#=vertical axis=#
set spacey [expr 25]
$w.frame10.picture create line 45 10 45 300 -arrow first -tags linexNA
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexNA

#=horizontal axis=#
set spacex [expr 20]
$w.frame10.picture create line 45 290 770 290 -arrow last -tags lineyNA

file delete NEAREST_AMINO_ACIDS-trajectory.txt
}
}

proc BALL {} {

variable w
variable counter_BALL

set checkBALL [molinfo top]
if {$checkBALL == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkBALL2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkBALL2 [$checkBALL2aux get index]
if {$checkBALL2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

set BALLlist ""
#if {[file exist MC.pdb] > 0} {
  if {$counter_BALL < 1} {
    set counter_BALL [expr $counter_BALL +1]
    set savepoint [molinfo top]
    foreach Molecule [molinfo list] {
      set BALLaux ""
      mol top $Molecule
      set ligand [atomselect top "resname [$w.frame1.entry4 get]"]
      lappend BALLaux [format "%.3f" [lindex [measure center $ligand] 0]]
      lappend BALLaux [format "%.3f" [lindex [measure center $ligand] 1]]
      lappend BALLaux [format "%.3f" [lindex [measure center $ligand] 2]]
      lappend BALLlist $BALLaux
    }
    mol top $savepoint
    foreach Molecule [molinfo list] {
      mol top $Molecule
      for {set pillar 0} {$pillar<[llength $BALLlist]} {incr pillar} {
        draw color pink
        draw sphere "[format "%.3f" [lindex [lindex $BALLlist $pillar] 0]]   [format "%.3f" [lindex [lindex $BALLlist $pillar] 1]]   [format "%.3f" [lindex [lindex $BALLlist $pillar] 2]]" radius 1.0
      }
    }
    mol top $savepoint
  } else {
    set counter_BALL 0
    set savepoint [molinfo top]
    foreach Molecule [molinfo list] {
      mol top $Molecule
      draw delete all
    }
    mol top $savepoint
  }
#}

}

proc MOVEON {} {

variable  w

set checkMOVEON [molinfo top]
if {$checkMOVEON == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

file mkdir EXTRA
set sel_moveon [atomselect [molinfo top] "all"]
$sel_moveon writepdb EXTRA/[molinfo top get filename]

}

proc LOAD2 {} {
variable w
variable RADIO
variable RADIO2

set checkLOAD2 [$w.frame7.coordinateEntry get]
if {$checkLOAD2 == ""} {
  tk_messageBox -message "Coordinate field is empty" -type ok -icon error
  return
}
set checkLOAD2 [$w.frame7.trajectoryEntry get]
if {$checkLOAD2 == ""} {
  tk_messageBox -message "Trajectory field is empty" -type ok -icon error
  return
}

if {[catch {mol new [$w.frame7.coordinateEntry get]}]} {
  tk_messageBox -message "Invalid value in Coordinate field" -type ok -icon error
  return
}

#mol new [$w.frame7.coordinateEntry get]

if {$RADIO < 1} {
mol addrep top
mol modstyle 0 top licorice
mol modselect 0 top "resname [$w.frame1.entry4 get]"
mol modstyle 1 top newcartoon
mol modcolor 1 top structure
mol addrep top
mol modstyle 2 top licorice

if {$RADIO2 < 1} {
  mol modselect 2 top "same residue as protein within 4 of resname [$w.frame1.entry4 get]"
  mol selupdate 2 top on
} else {
  mol modselect 2 top "same residue as nucleic within 4 of resname [$w.frame1.entry4 get]"
  mol selupdate 2 top on
}

} else {
mol addrep top
mol modstyle 0 top licorice
mol modselect 0 top "resname [$w.frame1.entry4 get]"
mol modstyle 1 top newcartoon
mol modcolor 1 top structure
mol addrep top
mol modstyle 2 top licorice
mol modselect 2 top "[$w.frame9.leftpanel.entry-yp2 get]"
}
if {[catch {mol addfile [$w.frame7.trajectoryEntry get] waitfor -1}]} {
  tk_messageBox -message "Invalid value in Trajectory field" -type ok -icon error
  return
}
#mol addfile [$w.frame7.trajectoryEntry get] waitfor -1
}

proc FIT {} {
variable w
variable RADIO2

set checkFIT [molinfo top]
if {$checkFIT == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

if {$RADIO2 < 1} {
  set reffit [atomselect top "structure E H and name CA" frame 0]
  set selfit [atomselect top "structure E H and name CA"]
} else {
  set reffit [atomselect top "nucleic" frame 0]
  set selfit [atomselect top "nucleic"]
}
set allfit [atomselect top all]
set nframe [molinfo top get numframes]

for {set frame 0} {$frame<$nframe} {incr frame} {
 $selfit frame $frame
 $allfit frame $frame
 $allfit move [measure fit $selfit $reffit]
}

}

proc CLUSTERTJ {} {

variable w
variable GRAPHICS
variable counter_ROD
variable CLTJlist
variable RADIO
variable RADIO2
variable MODALITY
variable LOADEDmolMD
variable LOADEDmolMDtotal


set GRAPHICS 5
set counter_ROD 0

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete linezCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

set checkCLUSTERTJ [molinfo top]
if {$checkCLUSTERTJ == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkFROM [$w.frame8.entryFrom get]
if {[string is integer $checkFROM] == 0} {
  tk_messageBox -message "Invalid value in FROM field" -type ok -icon error
  return
}

set checkTO [$w.frame8.entryTo get]
if {[string is integer $checkTO] == 0 || $checkTO > [molinfo top get numframes]} {
  tk_messageBox -message "Invalid value in TO field" -type ok -icon error
  return
}

set ymin [$w.frame8.entryFrom get]
set ymax [$w.frame8.entryTo get]
if {$ymax < $ymin} {
  tk_messageBox -message "The selected time interval is nonsense" -type ok -icon error
  return
}

if {[string is double [$w.frame8bis.clusterCutoff get]] == 0 || [$w.frame8bis.clusterCutoff get] < 0 || [$w.frame8bis.clusterCutoff get] == "-0"} {
  tk_messageBox -message "Error in CLUSTER treshold" -type ok -icon error
  return
}

set checkCLUSTERTJ2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkCLUSTERTJ2 [$checkCLUSTERTJ2aux get index]
if {$checkCLUSTERTJ2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

if {[file exist CLUSTER-FAMILIES] > 0} {
  file delete -force CLUSTER-FAMILIES
}

if {$LOADEDmolMD != ""} {
  foreach indication $LOADEDmolMD {
    mol delete $indication
  }
}

set conversionY [expr 250/($ymax.0 - $ymin.0)]

set clusterselection [atomselect top "resname [$w.frame1.entry4 get]"]

set CLTJlist ""
set varcluster [measure cluster $clusterselection num 100 distfunc rmsd cutoff [$w.frame8bis.clusterCutoff get] first $ymin last $ymax]
set counterTJ 0
for {set cltj 0} {$cltj <101} {incr cltj} {
  set CLTJaux ""
  if {[llength [lindex $varcluster $cltj]] > [expr ($ymax.0 - $ymin.0)*0.02]} {
    set counterTJ [expr $counterTJ +1]

    set xcltj [expr ($counterTJ*20)+45]
    set ycltj [llength [lindex $varcluster $cltj]]
    set yperfect [expr 290-($ycltj*$conversionY)]
    
    lappend CLTJaux $counterTJ
    lappend CLTJaux $ycltj
    lappend CLTJlist $CLTJaux

    set y2 [expr 290]

    set xrct [expr $xcltj-7]
    set xrct2 [expr $xcltj+7]


   $w.frame10.picture create rectangle $xrct $yperfect $xrct2 $y2 -fill {coral1} -tags pointsNA
   $w.frame10.picture create text $xcltj 308 -text $cltj -font {Helvetica -9} -tags coordNA
   $w.frame10.picture create line [expr $counterTJ*20 +45] 295 [expr $counterTJ*20 +45] 290 -tags pointsNA
  }
}

#file mkdir CLUSTER-FAMILIES

#for {set n 0} {$n<101} {incr n} {
#if {[llength [lindex $varcluster $n]] > [expr ($ymax.0 - $ymin.0)*0.02]} {
#set (cluster-$n) [atomselect top "all" frame [lindex [lindex $varcluster $n] 0]]
#$(cluster-$n) writepdb CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-$n.pdb
#}
#}

file mkdir CLUSTER-FAMILIES
set clusterselection [atomselect top "resname [$w.frame1.entry4 get]" frame $ymin]
set varcluster [measure cluster $clusterselection num 100 distfunc rmsd cutoff [$w.frame8bis.clusterCutoff get] first $ymin last $ymax]

#puts "VARCLUSTER: $varcluster"

for {set n 0} {$n<101} {incr n} {
  if {[llength [lindex $varcluster $n]] > [expr ($ymax.0 - $ymin.0)*0.02]} {
    set (cluster-$n) [atomselect top "all" frame [lindex [lindex $varcluster $n] 0]]
    $(cluster-$n) writepdb CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-$n.pdb
  }
}

set howmany [glob CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-* ]

if {[file exist CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-100.pdb] > 0} {
  file rename CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-100.pdb CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-[expr [llength $howmany]-1].pdb
}

##====To upload all the centroids on the VMD screen===###

set savepoint [molinfo top]
set counter 0
set listMOLID ""
for {set n 0} {$n<[llength $howmany]} {incr n} {
  incr counter
  mol new CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-$n.pdb
  lappend listMOLID [molinfo top]
  mol addrep [molinfo top]
  mol modstyle 0 [molinfo top] licorice
  mol modselect 0 [molinfo top] "resname [$w.frame1.entry4 get]"
  mol modstyle 1 [molinfo top] newcartoon
  mol modcolor 1 [molinfo top] structure
  mol addrep [molinfo top]
  mol modstyle 2 [molinfo top] licorice

  if {$RADIO2 < 1} {
    mol modselect 2 [molinfo top] "same residue as protein within 4 of resname [$w.frame1.entry4 get]"
  } else {
    mol modselect 2 [molinfo top] "same residue as nucleic within 4 of resname [$w.frame1.entry4 get]"
  }
  mol off [molinfo top]
}

mol top $savepoint

set LOADEDmolMDtotal [molinfo list]
set LOADEDmolMD [lreplace [molinfo list] 0 0]

#=vertical axis=#
set spacey [expr 25]
$w.frame10.picture create line 45 10 45 300 -arrow first -tags linexNA
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexNA
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexNA

set stickY [expr ($ymax.0 - $ymin.0)/5]

$w.frame10.picture create text 20 40 -text [format "%.2f" [expr $ymax - $ymin]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 240 -text [format "%.2f" $stickY] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 190 -text [format "%.2f" [expr $stickY*2]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 140 -text [format "%.2f" [expr $stickY*3]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 90 -text [format "%.2f" [expr $stickY*4]] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 20 290 -text [format "%.2f" 0] -font {Helvetica -9} -tags coordNA
$w.frame10.picture create text 32 18 -text "CL" -font {Times -13} -tags coordCM

#=horizontal axis=#
set spacex [expr 20]
$w.frame10.picture create line 45 290 770 290 -arrow last -tags lineyNA

}

proc FILTERVS {} {
variable w

set checkFILTERVS [molinfo top]
if {$checkFILTERVS == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkLC [$w.frame4.entryFP get]
if {[string is double $checkLC] == 0} {
  tk_messageBox -message "Invalid value in LC field" -type ok -icon error
  return
}

set checkES [$w.frame4.entryFP2 get]
if {[string is double $checkES] == 0} {
  tk_messageBox -message "Invalid value in ES field" -type ok -icon error
  return
}

set checkFILTERVS2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkFILTERVS2 [$checkFILTERVS2aux get index]
if {$checkFILTERVS2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

file mkdir VSresults-LC[$w.frame4.entryFP get]-ES[$w.frame4.entryFP2 get]
set counterFILTER 0
set savepoint [molinfo top]
foreach Molecule [molinfo list] {
  mol top $Molecule
  set pippo [atomselect [molinfo top] "resname [$w.frame1.entry4 get]"]
  if {[lindex [$pippo get occupancy] 0] > [$w.frame4.entryFP get] && [lindex [$pippo get beta] 0] < [$w.frame4.entryFP2 get]} {
    set paperino [atomselect top "all"]
    $paperino writepdb VSresults-LC[$w.frame4.entryFP get]-ES[$w.frame4.entryFP2 get]/[molinfo top get name]
    set counterFILTER [expr $counterFILTER +1]
  }
}
tk_messageBox -message "Filtered molecules: $counterFILTER" -type ok -icon info
mol top $savepoint
}

proc POSTSCRIPT {} {

variable w
variable GRAPHICS

set checkPOSTSCRIPT [molinfo top]
if {$checkPOSTSCRIPT == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

if {$GRAPHICS == 1} {
$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file ES.ps
}

if {$GRAPHICS == 2} {
$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file LC.ps
}

if {$GRAPHICS == 3} {
$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file NA.ps
}

if {$GRAPHICS == 4} {
$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file MC.ps
}

if {$GRAPHICS == 5} {
$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file TJ-CLUSTER.ps
}

if {$GRAPHICS == 6} {
$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file TJ-ES.ps
}

}

proc BALLTJ {} {

variable w
variable counter_BALL

set checkBALLTJ [molinfo top]
if {$checkBALLTJ == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkFROM [$w.frame8.entryFrom get]
if {[string is integer $checkFROM] == 0} {
  tk_messageBox -message "Invalid value in FROM field" -type ok -icon error
  return
}

set checkTO [$w.frame8.entryTo get]
if {[string is integer $checkTO] == 0} {
  tk_messageBox -message "Invalid value in TO field" -type ok -icon error
  return
}

if {[$w.frame8.entryTo get] < [$w.frame8.entryFrom get]} {
  tk_messageBox -message "The selected time interval is nonsense" -type ok -icon error
  return
}

set checkBALLTJ2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkBALLTJ2 [$checkBALLTJ2aux get index]
if {$checkBALLTJ2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

set BALLTJlist ""
#if {[file exist MC-trajectory.pdb] > 0} {
  if {$counter_BALL < 1} {
    set counter_BALL [expr $counter_BALL +1]
    set savepoint [molinfo top]
    for {set x [$w.frame8.entryFrom get]} {$x<[expr [$w.frame8.entryTo get]+1]} {incr x} {
      set BALLTJaux ""
      set ligand [atomselect top "resname [$w.frame1.entry4 get]" frame $x]
      lappend BALLTJaux [lindex [measure center $ligand] 0]
      lappend BALLTJaux [lindex [measure center $ligand] 1]
      lappend BALLTJaux [lindex [measure center $ligand] 2]
      lappend BALLTJlist $BALLTJaux      
    }
    for {set pillar 0} {$pillar<[llength $BALLTJlist]} {incr pillar} {
      draw color mauve
      draw sphere "[format "%.3f" [lindex [lindex $BALLTJlist $pillar] 0]]   [format "%.3f" [lindex [lindex $BALLTJlist $pillar] 1]]   [format "%.3f" [lindex [lindex $BALLTJlist $pillar] 2]]" radius 1.0
    }
    mol top $savepoint
  } else {
    set counter_BALL 0
    set savepoint [molinfo top]
    foreach Molecule [molinfo list] {
      mol top $Molecule
      draw delete all
    }
    mol top $savepoint
  }
#}
}

proc WRITE {} {

variable w
variable GRAPHICS
variable ESlist
variable LClist
variable NAlist
variable MClist
variable CLTJlist
variable BiCLTJlist

set checkWRITE [molinfo top]
if {$checkWRITE == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

if {$GRAPHICS == 1} {
set TEXT [open "ES.txt" w]
close $TEXT
set TEXT [open "ES.txt" a]
puts $TEXT "#DLG #Energy Score"
for {set x 0} {$x<[llength $ESlist]} {incr x} {
puts $TEXT [lindex $ESlist $x]
}
close $TEXT
}

if {$GRAPHICS == 2} {
set TEXT [open "LC.txt" w]
close $TEXT
set TEXT [open "LC.txt" a]
puts $TEXT "#DLG #Largest cluster"
for {set x 0} {$x<[llength $LClist]} {incr x} {
puts $TEXT [lindex $LClist $x]
}
close $TEXT
}

if {$GRAPHICS == 3} {
set TEXT [open "NA.txt" w]
close $TEXT
set TEXT [open "NA.txt" a]
puts $TEXT "#Amino-acids #Frequency"
for {set x 0} {$x<[llength $NAlist]} {incr x} {
puts $TEXT [lindex $NAlist $x]
}
close $TEXT
}

if {$GRAPHICS == 4} {
set TEXT [open "MC.txt" w]
close $TEXT
set TEXT [open "MC.txt" a]
puts $TEXT "#X #Y #Z"
for {set x 0} {$x<[llength $MClist]} {incr x} {
puts $TEXT [lindex $MClist $x]
}
close $TEXT
}

if {$GRAPHICS == 5} {
set TEXT [open "TJ-CLUSTER.txt" w]
close $TEXT
set TEXT [open "TJ-CLUSTER.txt" a]
puts $TEXT "#Cluster #Population"
for {set x 0} {$x<[llength $CLTJlist]} {incr x} {
puts $TEXT [lindex $CLTJlist $x]
}
close $TEXT
#$w.frame10.picture postscript -fontmap fontMap -height 320 -width 780 -file TJ-CLUSTER.ps
}

if {$GRAPHICS == 6} {
set TEXT [open "TJ-ES.txt" w]
close $TEXT
set TEXT [open "TJ-ES.txt" a]
puts $TEXT "#Cluster family #ES"
for {set x 0} {$x<[llength $BiCLTJlist]} {incr x} {
puts $TEXT [lindex $BiCLTJlist $x]
}
close $TEXT
}

}

proc SAVECL {} {

variable w
variable RADIO 
variable RADIO2
variable MODALITY
variable LOADEDmolMD
variable LOADEDmolMDtotal
variable GRAPHICS
variable BiCLTJlist

set GRAPHICS 6

$w.frame10.picture delete linexES
$w.frame10.picture delete lineyES
$w.frame10.picture delete pointsES
$w.frame10.picture delete coordES

$w.frame10.picture delete linexLC
$w.frame10.picture delete lineyLC
$w.frame10.picture delete pointsLC
$w.frame10.picture delete coordLC

$w.frame10.picture delete linexCM
$w.frame10.picture delete lineyCM
$w.frame10.picture delete linezCM
$w.frame10.picture delete pointsCM
$w.frame10.picture delete coordCM

$w.frame10.picture delete linexNA
$w.frame10.picture delete lineyNA
$w.frame10.picture delete pointsNA
$w.frame10.picture delete coordNA

set checkSAVECL [molinfo top]
if {$checkSAVECL == -1} {
  tk_messageBox -message "No molecules loaded" -type ok -icon error
  return
}

set checkFROM [$w.frame8.entryFrom get]
if {[string is integer $checkFROM] == 0} {
  tk_messageBox -message "Invalid value in FROM field" -type ok -icon error
  return
}

set checkTO [$w.frame8.entryTo get]
if {[string is integer $checkTO] == 0 || $checkTO > [molinfo top get numframes]} {
  tk_messageBox -message "Invalid value in TO field" -type ok -icon error
  return
}

set checkTOR [$w.frame8bis.clusterTorsion get]
if {[string is integer $checkTOR] == 0 || $checkTOR < 0} {
  tk_messageBox -message "Invalid value in TOR field" -type ok -icon error
  return
}

set checkLIMIT [$w.frame8bis.clusterLimit get]
if {[string is double $checkLIMIT] == 0 || $checkLIMIT < 1 || $checkLIMIT == "-0"} {
  tk_messageBox -message "Invalid value in SAVECL treshold" -type ok -icon error
  return
}

if {[file exist CLUSTER-FAMILIES] == 0} {
  tk_messageBox -message "Press the CL button before going on" -type ok -icon error
  return
}

set ymin [$w.frame8.entryFrom get]
set ymax [$w.frame8.entryTo get]
if {$ymax < $ymin} {
  tk_messageBox -message "The selected time interval is nonsense" -type ok -icon error
  return
}

set checkSAVECL2aux [atomselect top "resname [$w.frame1.entry4 get]"]
set checkSAVECL2 [$checkSAVECL2aux get index]
if {$checkSAVECL2 == ""} {
  tk_messageBox -message "Wrong ligand name" -type ok -icon error
  return
}

set listPROTEINtop [glob *.top]
set listPROTEINitp [glob *.itp]
append listPROTEINtop " " $listPROTEINitp
set receptorTOP [split [$w.frame7bis.topReceptorEntry get] "/"]
set receptorTOPNAME [lindex $receptorTOP [expr [llength $receptorTOP]-1]]
if {[lsearch $listPROTEINtop $receptorTOPNAME] == "-1"} {
  tk_messageBox -message "Invalid value in Receptor topology field" -type ok -icon error
  return
}

set receptorTOP [split [$w.frame7bis.topLigandEntry get] "/"]
set receptorTOPNAME [lindex $receptorTOP [expr [llength $receptorTOP]-1]]
if {[lsearch $listPROTEINtop $receptorTOPNAME] == "-1"} {
  tk_messageBox -message "Invalid value in Ligand topology field" -type ok -icon error
  return
}

if {$LOADEDmolMD == ""} {
  tk_messageBox -message "Press the CL button before going on" -type ok -icon error
  return
}

#file mkdir CLUSTER-FAMILIES
#set clusterselection [atomselect top "resname [$w.frame1.entry4 get]" frame $ymin]
#set varcluster [measure cluster $clusterselection num 100 distfunc rmsd cutoff [$w.frame8bis.clusterCutoff get] first $ymin last $ymax]

#puts "VARCLUSTER: $varcluster"

#for {set n 0} {$n<101} {incr n} {
#  if {[llength [lindex $varcluster $n]] > [expr ($ymax.0 - $ymin.0)*0.02]} {
#    set (cluster-$n) [atomselect top "all" frame [lindex [lindex $varcluster $n] 0]]
#    $(cluster-$n) writepdb CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-$n.pdb
#  }
#}

set howmany [glob CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-* ]

#if {[file exist CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-100.pdb] > 0} {
#  file rename CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-100.pdb CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-[expr [llength $howmany]-1].pdb
#}

##====To upload all the centroids on the VMD screen===###

#set savepoint [molinfo top]
#set counter 0 
#set listMOLID ""
#for {set n 0} {$n<[llength $howmany]} {incr n} {
#  incr counter
#  mol new CLUSTER-FAMILIES/cluster-[$w.frame8bis.clusterCutoff get]-$n.pdb
#  lappend listMOLID [molinfo top] 
#  mol addrep [molinfo top] 
#  mol modstyle 0 [molinfo top] licorice
#  mol modselect 0 [molinfo top] "resname [$w.frame1.entry4 get]"
#  mol modstyle 1 [molinfo top] newcartoon
#  mol modcolor 1 [molinfo top] structure
#  mol addrep [molinfo top]
#  mol modstyle 2 [molinfo top] licorice

#  if {$RADIO2 < 1} {
#    mol modselect 2 [molinfo top] "same residue as protein within 4 of resname [$w.frame1.entry4 get]"
#  } else {
#    mol modselect 2 [molinfo top] "same residue as nucleic within 4 of resname [$w.frame1.entry4 get]"
#  }
#  mol off [molinfo top]
#}

#mol top $savepoint

set LOADEDmolMDtotal [molinfo list]
set LOADEDmolMD [lreplace [molinfo list] 0 0]

###PER caricare topologia recettore####
set text [open [$w.frame7bis.topReceptorEntry get]]
set aux [read $text]
set auxsplit [split $aux "\n"]

for {set x 0} {$x<[llength $auxsplit]} {incr x} {
  if {[lindex [lindex $auxsplit $x] 1] == "atoms"} {
    set upperbound $x
  }
  if {[lindex [lindex $auxsplit $x] 1] == "bonds"} {
    set lowerbound $x
  }
}
set proteinTOP ""
for {set x [expr $upperbound+1]} {$x< [expr $lowerbound-1]} {incr x} {
 if {[lindex [lindex $auxsplit $x] 0] != ";"} {
   set pinco [lindex [lindex $auxsplit $x] 6]
   set panco [format "%.2f" $pinco ]
   lappend proteinTOP $panco
 }
}
######################################
###To read the ligand topology######
set text [open [$w.frame7bis.topLigandEntry get]]
set aux [read $text]
set auxsplit [split $aux "\n"]

for {set x 0} {$x<[llength $auxsplit]} {incr x} {
  if {[lindex [lindex $auxsplit $x] 1] == "atoms"} {
    set upperbound $x
  }
  if {[lindex [lindex $auxsplit $x] 1] == "bonds"} {
    set lowerbound $x
  }
}

set ligandTOP ""

for {set x [expr $upperbound+1]} {$x< [expr $lowerbound-1]} {incr x} {
 if {[lindex [lindex $auxsplit $x] 0] != ";"} {
   set pinco [lindex [lindex $auxsplit $x] 6]
   set panco [format "%.2f" $pinco ]
   lappend ligandTOP $panco
 }
}
################################################################
######To write the electric charge values on the beta-factor####
foreach i $LOADEDmolMD {
  set prot [atomselect $i "not resname [$w.frame1.entry4 get] and not water and not ions"]
  for {set minni [lindex [$prot get index] 0]} {$minni< [lindex [$prot get index] end]} {incr minni} {
    set orazio [atomselect $i "(not resname UNL and not water and not ions) and index $minni"]
    $orazio set beta [lindex $proteinTOP $minni]
  }
  set lig [atomselect $i "resname [$w.frame1.entry4 get]"]
  for {set betta [lindex [$lig get index] 0]} {$betta< [lindex [$lig get index] end]} {incr betta} {
    set bassettoni [atomselect $i "resname [$w.frame1.entry4 get] and index $betta"]
    $bassettoni set beta [lindex $ligandTOP [expr $betta-[lindex [$lig get index] 0]]]
  }
}

#puts $LOADEDmolMD
###################################
set BindingLIST ""
foreach i $LOADEDmolMD {
  set CLOROligand [atomselect $i "name \"CL.*\" or name \"Cl.*\" "]
  set CLOROligandlist [$CLOROligand get index]
  set aromaticLIGANDlist ""
  set ligandSP2 [atomselect $i "(numbonds 3 and name \"C.*\") and resname [$w.frame1.entry4 get]"]
  set ligandSP2list [$ligandSP2 get index]
  foreach k $ligandSP2list {
    set LIMITlist ""
    set endroad "zero"
    set LIMIT $k
    set Outline [atomselect $i "(within 1.6 of index $LIMIT) and not index $LIMIT"]
    set road1 [lindex [$Outline get index] 0]
    set road2 [lindex [$Outline get index] 1]
    set road3 [lindex [$Outline get index] 2]    
    set Outline2 [atomselect $i "(within 1.6 of index $road1) and not index $road1 $LIMIT"]
    set Outline3 [atomselect $i "(within 1.6 of index $road2) and not index $road2 $LIMIT"]
    set Outline4 [atomselect $i "(within 1.6 of index $road3) and not index $road3 $LIMIT"]
    set road1bis [lindex [$Outline2 get index] 0]
    set road1tris [lindex [$Outline2 get index] 1]
    set road2bis [lindex [$Outline3 get index] 0]
    set road2tris [lindex [$Outline3 get index] 1]
    set road3bis [lindex [$Outline4 get index] 0]
    set road3tris [lindex [$Outline4 get index] 1]
    if {$road1bis != ""} {
      set Outline2bis [atomselect $i "(within 1.6 of index $road1bis) and not index $road1bis $road1"]
    } else {
      set Outline2bis [atomselect $i "all and z> 999999999"]
    }
    if {$road1tris != ""} {
      set Outline2tris [atomselect $i "(within 1.6 of index $road1tris) and not index $road1tris $road1"]
    } else {
      set Outline2tris [atomselect $i "all and z> 999999999"]
    }
    if {$road2bis != ""} {
      set Outline3bis [atomselect $i "(within 1.6 of index $road2bis) and not index $road2bis $road2"]
    } else {
      set Outline3bis [atomselect $i "all and z> 999999999"]
    }
    if {$road2tris != ""} {
      set Outline3tris [atomselect $i "(within 1.6 of index $road2tris) and not index $road2tris $road2"]
    } else {
      set Outline3tris [atomselect $i "all and z> 999999999"]
    }
    if {$road3bis != ""} {
      set Outline4bis [atomselect $i "(within 1.6 of index $road3bis) and not index $road3bis $road3"]
    } else {
      set Outline4bis [atomselect $i "all and z> 999999999"]
    }
    if {$road3tris != ""} {
      set Outline4tris [atomselect $i "(within 1.6 of index $road3tris) and not index $road3tris $road3"]
    } else {
      set Outline4tris [atomselect $i "all and z> 999999999"]
    }
    lappend LIMITlist "[$Outline2bis get index] [$Outline2tris get index] [$Outline3bis get index] [$Outline3tris get index] [$Outline4bis get index] [$Outline4tris get index]"
#    puts $LIMITlist
    set RING5 0
    set RINGlist ""
    if {[lsearch [lindex $LIMITlist 0] $road1bis] != -1} {
      lappend RINGlist $road1
      lappend RINGlist $road1bis
      set RING5 [expr $RING5 + 1]
    } 
    if {[lsearch [lindex $LIMITlist 0] $road1tris] != -1} {
      lappend RINGlist $road1
      lappend RINGlist $road1tris
      set RING5 [expr $RING5 + 1]
    }
    if {[lsearch [lindex $LIMITlist 0] $road2bis] != -1} {
      lappend RINGlist $road2
      lappend RINGlist $road2bis
      set RING5 [expr $RING5 + 1]
    }
    if {[lsearch [lindex $LIMITlist 0] $road2tris] != -1} {
      lappend RINGlist $road2
      lappend RINGlist $road2tris
      set RING5 [expr $RING5 + 1]
    }
    if {[lsearch [lindex $LIMITlist 0] $road3bis] != -1} {
      lappend RINGlist $road3
      lappend RINGlist $road3bis
      set RING5 [expr $RING5 + 1]
    }
    if {[lsearch [lindex $LIMITlist 0] $road3tris] != -1} {
      lappend RINGlist $road3
      lappend RINGlist $road3tris
      set RING5 [expr $RING5 + 1]
    }
#    puts "5-membered ring = $RING5"
    if {$RING5 == 2} {
      lappend RINGlist $LIMIT
    }
#    puts $RINGlist   
    if {$RINGlist != ""} { 
      set siono5 [atomselect $i "(index $RINGlist) and ((numbonds 3 and name \"C.*\") or name \"N.*\" \"S.*\" \"O.*\")"]
      set sannianCHECK [atomselect $i "(index $RINGlist) and (name \"O.*\")"]
      if {[llength [$siono5 get index]] == 5 && [llength [$sannianCHECK get index]] < 2} {
#        puts "Aromatic 5-membered ring= $RINGlist"
        foreach adjunt5 $RINGlist {
            set check $adjunt5
            if {[regexp $check $aromaticLIGANDlist] < 1} {
              lappend aromaticLIGANDlist $check
            }
        }
      }
    }

    foreach h [lindex $LIMITlist 0] {
      set re "\\m$h\\M"
      if {[regexp -all $re [lindex $LIMITlist 0]] == 2} {
        set endroad $h
      }
    }
    set RING ""
    lappend RING $endroad
    set check "\\m$endroad\\M"
    if {[regexp $check [$Outline2bis get index]] == 1} {
      lappend RING $road1bis
      lappend RING $road1
    }
    if {[regexp $check [$Outline2tris get index]] == 1} {
      lappend RING $road1tris
      lappend RING $road1
    }
    if {[regexp $check [$Outline3bis get index]] == 1} {
      lappend RING $road2bis
      lappend RING $road2
    }
    if {[regexp $check [$Outline3tris get index]] == 1} {
      lappend RING $road2tris
      lappend RING $road2
    }
    if {[regexp $check [$Outline4bis get index]] == 1} {
      lappend RING $road3bis
      lappend RING $road3
    }
    if {[regexp $check [$Outline4tris get index]] == 1} {
      lappend RING $road3tris
      lappend RING $road3
    }
    lappend RING $LIMIT

    if {$endroad != "zero"} {
      set siono [atomselect $i "(index $RING) and ((numbonds 3 and name \"C.*\") or name \"N.*\")"]
        if {[llength [$siono get index]] == 6} {
          foreach adjunt $RING {
            set check $adjunt
            if {[regexp $check $aromaticLIGANDlist] < 1} {
              lappend aromaticLIGANDlist $check
            }
          }
        }
#    puts "closed RING ==== $aromaticLIGANDlist"
     }
  }
  ###this is the end of aromaticLIGANDlist####
#  puts $aromaticLIGANDlist
  set ligand [atomselect $i "resname [$w.frame1.entry4 get]"]
  set ligandAD4 [atomselect $i "resname [$w.frame1.entry4 get] and not (name \"H.*\" and within 1.3 of name \"C.*\")"]
  set Limit [$w.frame8bis.clusterLimit get]
  set Outline [atomselect $i "(within $Limit of resname [$w.frame1.entry4 get]) and not resname [$w.frame1.entry4 get]"]
  set OutlineAD4 [atomselect $i "(within $Limit of resname [$w.frame1.entry4 get]) and not resname [$w.frame1.entry4 get] and not (name \"H.*\" and within 1.3 of name \"C.*\")"]
  set OutlineSP2 [atomselect $i "(numbonds 3 and name \"C.*\" and (within $Limit of resname [$w.frame1.entry4 get])) and not resname [$w.frame1.entry4 get]"]
  set OutlineSP2list [$OutlineSP2 get index]
  set aromaticSURROUNDlist ""
  foreach k $OutlineSP2list {
    set auxSP2 [atomselect $i "index $k"]
    set nameSP2 [$auxSP2 get name]
    set resnameSP2 [$auxSP2 get resname]
    if {$RADIO2 < 1} {
      if {$nameSP2 != "C"} {
        if {$resnameSP2 == "PHE" || $resnameSP2 == "TRP" || $resnameSP2 == "HIS" || $resnameSP2 == "TYR"} { 
          lappend aromaticSURROUNDlist $k
 #        puts [$auxSP2 get {resname name}]
        }
      }
    } else {
      lappend aromaticSURROUNDlist $k
    }
  }
  ###this is the end of aromaticSURROUNDlist####

set ligandLIST ""
for {set x 0} {$x<[llength [$ligand get index]]} {incr x} {
  set macho [lindex [$ligand get {index name beta}] $x]
  set atomname [lindex [$ligand get name] $x]
  set aux [split $atomname {}]
  set atomtype [lindex $aux 0]

  if [string is integer -strict $atomtype] {
     set atomtype [lindex $aux 1]
  }

    if {$atomtype == "C"} {
      if {[lsearch -exact $aromaticLIGANDlist [lindex [$ligand get index] $x]] >0} {
        set atomtype A
      }
      if {[lsearch -exact $CLOROligandlist [lindex [$ligand get index] $x]] >0} {
        set atomtype L
      }
    }
  lappend macho $atomtype
  if {$atomtype == "H"} {
    set rmin1 [expr 2.0]
    set eps1 [expr 0.02]
    set asp [expr 0.00051]
    set vol [expr 0]
  }
  if {$atomtype == "C"} {
    set rmin1 [expr 4.0]
    set eps1 [expr 0.15]
    set asp [expr -0.00143]
    set vol [expr 33.5103]
  }
  if {$atomtype == "N"} {
    set rmin1 [expr 3.50]
    set eps1 [expr 0.1600]
    set asp [expr -0.00162]
    set vol [expr 22.4493]
  }
  if {$atomtype == "O"} {
    set rmin1 [expr 3.20]
    set eps1 [expr 0.200]
    set asp [expr -0.00251]
    set vol [expr 17.1573]
  }
  if {$atomtype == "A"} {
    set rmin1 [expr 4.0]
    set eps1 [expr 0.15]
    set asp [expr -0.00052]
    set vol [expr 33.5103]
  }
  if {$atomtype == "S"} {
    set rmin1 [expr 4.0]
    set eps1 [expr 0.20]
    set asp [expr -0.00214]
    set vol [expr 33.5103]
  }
  if {$atomtype == "P"} {
    set rmin1 [expr 4.2]
    set eps1 [expr 0.20]
    set asp [expr -0.00110]
    set vol [expr 38.7924]
  }
  if {$atomtype == "F"} {
    set rmin1 [expr 3.09]
    set eps1 [expr 0.080]
    set asp [expr -0.00110]
    set vol [expr 15.4480]
  }
  if {$atomtype == "B"} {
    set rmin1 [expr 4.33]
    set eps1 [expr 0.389]
    set asp [expr -0.00110]
    set vol [expr 42.5661]
  }
  if {$atomtype == "I"} {
    set rmin1 [expr 4.72]
    set eps1 [expr 0.550]
    set asp [expr -0.00110]
    set vol [expr 55.0585]
  }
  if {$atomtype == "Z"} {
    set rmin1 [expr 1.48]
    set eps1 [expr 0.550]
    set asp [expr -0.00110]
    set vol [expr 1.7000]
  }
  if {$atomtype == "L"} {
    set rmin1 [expr 4.09]
    set eps1 [expr 0.276]
    set asp [expr -0.00110]
    set vol [expr 35.8235]
  }
  lappend macho $rmin1
  lappend macho $eps1
  lappend macho $asp
  lappend macho $vol

  lappend ligandLIST $macho
}

set ligandAD4list ""
for {set x 0} {$x<[llength [$ligand get index]]} {incr x} {
  if {[lsearch -exact [$ligandAD4 get index] [lindex [lindex $ligandLIST $x] 0]] >0} {
#    puts "$x === [lindex $ligandLIST $x]"
    lappend ligandAD4list [lindex $ligandLIST $x]
  }
}
#puts $ligandAD4list
#puts "STOP"


set OutlineLIST ""
for {set x 0} {$x<[llength [$Outline get index]]} {incr x} {
  set micio [lindex [$Outline get {index name beta}] $x]
  set atomname [lindex [$Outline get name] $x]
  set aux [split $atomname {}]
  set atomtype [lindex $aux 0]

  if [string is integer -strict $atomtype] {
     set atomtype [lindex $aux 1]
  }
    if {$atomtype == "C"} {
      if {[llength $aux] >1} {
        if {[lsearch -exact $aromaticSURROUNDlist [lindex [$Outline get index] $x]] >0} {
          set atomtype A
        }
      }
    }
  lappend micio $atomtype
  if {$atomtype == "H"} {
    set rmin1 [expr 2.0]
    set eps1 [expr 0.02]
    set asp [expr 0.00051]
    set vol [expr 0]
  }
  if {$atomtype == "C"} {
    set rmin1 [expr 4.0]
    set eps1 [expr 0.15]
    set asp [expr -0.00143]
    set vol [expr 33.5103]
  }
  if {$atomtype == "N"} {
    set rmin1 [expr 3.50]
    set eps1 [expr 0.1600]
    set asp [expr -0.00162]
    set vol [expr 22.4493]
  }
  if {$atomtype == "O"} {
    set rmin1 [expr 3.20]
    set eps1 [expr 0.200]
    set asp [expr -0.00251]
    set vol [expr 17.1573]
  }
  if {$atomtype == "A"} {
    set rmin1 [expr 4.0]
    set eps1 [expr 0.15]
    set asp [expr -0.00052]
    set vol [expr 33.5103]
  }
  if {$atomtype == "S"} {
    set rmin1 [expr 4.0]
    set eps1 [expr 0.20]
    set asp [expr -0.00214]
    set vol [expr 33.5103]
  }
  if {$atomtype == "P"} {
    set rmin1 [expr 4.2]
    set eps1 [expr 0.20]
    set asp [expr -0.00110]
    set vol [expr 38.7924]
  }
  if {$atomtype == "F"} {
    set rmin1 [expr 3.09]
    set eps1 [expr 0.080]
    set asp [expr -0.00110]
    set vol [expr 15.4480]
  }
####### B is the Bromine #######
  if {$atomtype == "B"} {
    set rmin1 [expr 4.33]
    set eps1 [expr 0.389]
    set asp [expr -0.00110]
    set vol [expr 42.5661]
  }
  if {$atomtype == "I"} {
    set rmin1 [expr 4.72]
    set eps1 [expr 0.550]
    set asp [expr -0.00110]
    set vol [expr 55.0585]
  }
###### Z is the Zinc #######
  if {$atomtype == "Z"} {
    set rmin1 [expr 1.48]
    set eps1 [expr 0.550]
    set asp [expr -0.00110]
    set vol [expr 1.7000]
  }
###### L is the Chlorine #######
  if {$atomtype == "L"} {
    set rmin1 [expr 4.09]
    set eps1 [expr 0.276]
    set asp [expr -0.00110]
    set vol [expr 35.8235]
  }
  lappend micio $rmin1
  lappend micio $eps1
  lappend micio $asp
  lappend micio $vol

  lappend OutlineLIST $micio
}

set OutlineAD4list ""
for {set x 0} {$x<[llength [$Outline get index]]} {incr x} {
  if {[lsearch -exact [$OutlineAD4 get index] [lindex [lindex $OutlineLIST $x] 0]] >0} {
#    puts "$x === [lindex $OutlineLIST $x]"
    lappend OutlineAD4list [lindex $OutlineLIST $x]
  }
}
#puts $OutlineAD4list
#puts "STOP"

####this is the end of the tables creation procedure####

##variabili da iniziare
set energyELEC 0
set caricaLIGAND 0
set caricaSURROUND 0
set ELEC ""
set VDW ""
set energyVDW 0
set SOLV ""
set energySOLV 0
set HBONDS ""
set energyHBONDS 0
#######################

####ELECTROSTATIC#####
set parzialeELEC ""
set resultELEC 0
for {set k 0} {$k < [llength [$ligand get index]]} {incr k} {
  set caricaLIGAND [lindex [lindex $ligandLIST $k] 2]
  for {set j 0} {$j< [llength [$Outline get index]]} {incr j} {
    set caricaSURROUND [lindex [lindex $OutlineLIST $j] 2]
    set couple [lindex [lindex $ligandLIST $k] 0]
    lappend couple [lindex [lindex $OutlineLIST $j] 0]
    set distance [measure bond $couple molid $i]

    set epsMS [expr -8.5525+(86.9525/(1+(7.7839*pow(2.71,[expr -0.003627*86.9525*$distance]))))]
    set unityCHARGE [expr -1.602e-19]
    set kappa [expr 1/(4*3.14*(8.854e-12)*$epsMS)]
    set ENELEC [expr $kappa*(($caricaLIGAND*$unityCHARGE)*($caricaSURROUND*$unityCHARGE)/($distance*(1e-10)))]
    set energyPART [expr ($ENELEC*(6.022e23))*0.000239]

    set energyELEC [expr $energyELEC + $energyPART]
  }
 lappend parzialeELEC [expr 0.1406*$energyELEC]
 set energyELEC 0
}
for {set m 0} {$m<[llength [$ligand get index]]} {incr m} {
set resultELEC [expr $resultELEC + [format "%.2f" [lindex $parzialeELEC $m]]]
}
#puts [format "%.2f" $resultELEC]

#####VDW#####
set parzialeVDW ""
set resultVDW 0
for {set k 0} {$k < [llength $ligandAD4list]} {incr k} {
  set rminLIGANDO [lindex [lindex $ligandAD4list $k] 4]
  set epsLIGANDO [lindex [lindex $ligandAD4list $k] 5]
  for {set j 0} {$j< [llength $OutlineAD4list]} {incr j} {
    set rminSURROUND [lindex [lindex $OutlineAD4list $j] 4]
    set epsSURROUND [lindex [lindex $OutlineAD4list $j] 5]
    set couple [lindex [lindex $ligandAD4list $k] 0]
    lappend couple [lindex [lindex $OutlineAD4list $j] 0]
    set distance [measure bond $couple molid $i]

    set rij [expr ($rminLIGANDO+$rminSURROUND)/2]
    set epsij [expr sqrt($epsLIGANDO*$epsSURROUND)]
    set pauli [expr pow([expr $rij/$distance],12)]
    set london [expr pow([expr $rij/$distance],6)]
    set energyPART [expr 4*$epsij*((0.25*$pauli)-(0.5*$london))]

    set energyVDW [expr $energyVDW + $energyPART]
  }
 lappend parzialeVDW [expr 0.1662*$energyVDW]
 set energyVDW 0
}
for {set m 0} {$m<[llength $ligandAD4list]} {incr m} {
set resultVDW [expr $resultVDW + [lindex $parzialeVDW $m]]
}
#puts [format "%.2f" $resultVDW]

#######SOLVATION######

set parzialeSOLV ""
set resultSOLV 0
for {set k 0} {$k < [llength $ligandAD4list]} {incr k} {
  set caricaLIGAND [lindex [lindex $ligandAD4list $k] 2]
  set aspLIGAND [lindex [lindex $ligandAD4list $k] 6]
  set volLIGAND [lindex [lindex $ligandAD4list $k] 7]
#  set ABScaricaLIGAND [expr $caricaLIGAND]
  set ABScaricaLIGAND [expr abs($caricaLIGAND)]
  for {set j 0} {$j< [llength $OutlineAD4list]} {incr j} {
    set caricaSURROUND [lindex [lindex $OutlineAD4list $j] 2]
    set aspSURROUND [lindex [lindex $OutlineAD4list $j] 6]
    set volSURROUND [lindex [lindex $OutlineAD4list $j] 7]
    set couple [lindex [lindex $ligandAD4list $k] 0]
    lappend couple [lindex [lindex $OutlineAD4list $j] 0]
    set distance [measure bond $couple molid $i]
#    set ABScaricaSURROUND [expr $caricaSURROUND]  
    set ABScaricaSURROUND [expr abs($caricaSURROUND)]
#    puts "$caricaLIGAND --- $ABScaricaLIGAND --- $caricaSURROUND ---  $ABScaricaSURROUND"

    set pluto [expr (($aspLIGAND+0.01097*$caricaLIGAND)*$volSURROUND)+(($aspSURROUND+0.01097*$caricaSURROUND)*$volLIGAND)]
    set coeff [expr -(($distance*$distance)/24.5)]
    set desolvENERGY [expr $pluto*(pow(2.72,$coeff))]
    set energySOLV [expr $energySOLV + [format "%.2f" $desolvENERGY]]
  }
  lappend parzialeSOLV [expr 0.1322*$energySOLV]
  set energySOLV 0
}
for {set m 0} {$m<[llength $ligandAD4list]} {incr m} {
set resultSOLV [expr $resultSOLV + [format "%.2f" [lindex $parzialeSOLV $m]]]
}
#puts $resultSOLV

#######HBONDS#######
set energyHBONDS 0
set ligandHdon [atomselect $i "name \"H.*\" and within 1.3 of (name \"N.*\" \"O.*\" \"S.*\") and resname [$w.frame1.entry4 get]"]
set ligandACCEPTOR [atomselect $i "name \"N.*\" \"O.*\" \"S.*\" and not (within 1.3 of name \"H.*\") and resname [$w.frame1.entry4 get]"]
set OutlineHdon [atomselect $i "((within $Limit of resname [$w.frame1.entry4 get]) and not resname [$w.frame1.entry4 get]) and (name \"H.*\" and within 1.3 of (name \"N.*\" \"O.*\" \"S.*\"))"]
set OutlineACCEPTOR [atomselect $i "((within $Limit of resname [$w.frame1.entry4 get]) and not resname [$w.frame1.entry4 get]) and (name \"N.*\" \"O.*\" \"S.*\" and not (within 1.3 of name \"H.*\"))"]

#puts "ligandHdon : [llength [$ligandHdon get index]]"
#puts "ligandACCEPTOR : [llength [$ligandACCEPTOR get index]]"
#puts "OutlineHdon : [llength [$OutlineHdon get index]]"
#puts "OutlineACCEPTOR : [llength [$OutlineACCEPTOR get index]]"

for {set k 0} {$k < [llength [$ligandHdon get index]]} {incr k} {
  set DONOR [atomselect $i "(name \"N.*\" \"O.*\" \"S.*\") and within 1.3 of index [lindex [$ligandHdon get index] $k]"]
  set atomnameDON [$DONOR get name]
  set auxDON [split $atomnameDON {}]
  set atomtypeDON [lindex $auxDON 0]
  for {set j 0} {$j< [llength [$OutlineACCEPTOR get index]]} {incr j} {
    set angleHB ""
    lappend angleHB [$DONOR get index]
    set couple [lindex [$ligandHdon get index] $k]
    lappend angleHB [lindex [$ligandHdon get index] $k]
    lappend couple [lindex [$OutlineACCEPTOR get index] $j]
    lappend angleHB [lindex [$OutlineACCEPTOR get index] $j]
    set distance [measure bond $couple molid $i]
    set angleMEASURE [measure angle $angleHB molid $i]
    if {$angleMEASURE > 89.999} {
     if {$atomtypeDON == "N"} {
        set angleDEF [expr pow((cos($angleMEASURE/180*3.14)),2)]
     } else {
        set angleDEF [expr pow((cos($angleMEASURE/180*3.14)),4)]
     }
#     puts $couple
#     puts $angleHB
#     puts "DISTANZA: $distance"
#     puts "$angleMEASURE --- coseno: $angleDEF"
     set atomnameACC [lindex [$OutlineACCEPTOR get name] $j]
     set auxACC [split $atomnameACC {}]
     set atomtypeACC [lindex $auxACC 0]
       if {$atomtypeACC == "O"} {
         set rminHB 1.9
         set epsHB 5.0
       }
       if {$atomtypeACC == "N"} {
         set rminHB 1.9
         set epsHB 5.0
       }
       if {$atomtypeACC == "S"} {
         set rminHB 2.5
         set epsHB 1.0
       }
     set repuHB [expr 0.25*pow([expr $rminHB/$distance],12)]
     set attraHB [expr 0.5*pow([expr $rminHB/$distance],10)]
     set energyHBONDSpart [expr $angleDEF*(4*$epsHB*($repuHB - $attraHB))]
     set energyHBONDS [expr $energyHBONDS + $energyHBONDSpart]
#     puts "ENERGY: $energyHBONDSpart"
    }
  }
}
#puts "ENERGY TOT: [expr 0.1209*$energyHBONDS]"
#puts [format "%.2f" [expr 0.1209*$energyHBONDS]]

for {set k 0} {$k < [llength [$OutlineHdon get index]]} {incr k} {
  set DONOR [atomselect $i "(name \"N.*\" \"O.*\" \"S.*\") and within 1.3 of index [lindex [$OutlineHdon get index] $k]"]
  set atomnameDON [$DONOR get name]
  set auxDON [split $atomnameDON {}]
  set atomtypeDON [lindex $auxDON 0]
  for {set j 0} {$j< [llength [$ligandACCEPTOR get index]]} {incr j} {
    set angleHB ""
    lappend angleHB [$DONOR get index]
    set couple [lindex [$OutlineHdon get index] $k]
    lappend angleHB [lindex [$OutlineHdon get index] $k]
    lappend couple [lindex [$ligandACCEPTOR get index] $j]
    lappend angleHB [lindex [$ligandACCEPTOR get index] $j]
    set distance [measure bond $couple molid $i]
    set angleMEASURE [measure angle $angleHB molid $i]
    if {$angleMEASURE > 89.999} {
     if {$atomtypeDON == "N"} {
        set angleDEF [expr pow((cos($angleMEASURE/180*3.14)),2)]
     } else {
        set angleDEF [expr pow((cos($angleMEASURE/180*3.14)),4)]
     }
     set atomnameACC [lindex [$ligandACCEPTOR get name] $j]
     set auxACC [split $atomnameACC {}]
     set atomtypeACC [lindex $auxACC 0]
       if {$atomtypeACC == "O"} {
         set rminHB 1.9
         set epsHB 5.0
       }
       if {$atomtypeACC == "N"} {
         set rminHB 1.9
         set epsHB 5.0
       }
       if {$atomtypeACC == "S"} {
         set rminHB 2.5
         set epsHB 1.0
       }
     set repuHB [expr 0.25*pow([expr $rminHB/$distance],12)]
     set attraHB [expr 0.5*pow([expr $rminHB/$distance],10)]
     set energyHBONDSpart [expr $angleDEF*(4*$epsHB*($repuHB - $attraHB))]
     set energyHBONDS [expr $energyHBONDS + $energyHBONDSpart]
    }
  }
}

#puts [format "%.2f" [expr 0.1209*$energyHBONDS]]

set resultTOTALE [expr $resultELEC + $resultVDW + $resultSOLV + (0.1209*$energyHBONDS)]
#puts "Binding energy : [format "%.2f" $resultTOTALE]"
set TORSIONAL [expr 0.2983*[$w.frame8bis.clusterTorsion get]]
lappend BindingLIST [expr [format "%.2f" $resultTOTALE]+$TORSIONAL]
}

set ymin 0
foreach i $BindingLIST {
  if {$ymin > $i} {
     set ymin $i
  }
}
set conversionY [expr 250/[expr -$ymin]]

#=vertical axis=#
set spacey [expr 25]
$w.frame10.picture create line 45 0 45 300 -arrow last -tags linexES
$w.frame10.picture create line 40 [expr $spacey +15] 45 [expr $spacey +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*2 +15] 45 [expr $spacey*2 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*3 +15] 45 [expr $spacey*3 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*4 +15] 45 [expr $spacey*4 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*5 +15] 45 [expr $spacey*5 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*6 +15] 45 [expr $spacey*6 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*7 +15] 45 [expr $spacey*7 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*8 +15] 45 [expr $spacey*8 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*9 +15] 45 [expr $spacey*9 +15] -tags linexES
$w.frame10.picture create line 40 [expr $spacey*10 +15] 45 [expr $spacey*10 +15] -tags linexES
$w.frame10.picture create text 32 293 -text "ES" -font {Times -13} -tags coordCM

#=horizontal axis=#
set spacex [expr 20]
$w.frame10.picture create line 35 15 770 15 -arrow last -tags lineyES

set counter 0
set BiCLTJlist ""
foreach i $BindingLIST {
  set CLTJaux ""
  set x [incr $counter]
  set xauxi [expr ($x*$spacex)+45]
  set y $i
  if {$y >0} {
  set y 0
  }
  lappend CLTJaux $x
  lappend CLTJaux $y
  lappend BiCLTJlist $CLTJaux

  set yperfect [expr (-($y*$conversionY))+15]
  $w.frame10.picture create oval [expr $xauxi +3] [expr $yperfect +3] [expr $xauxi -3] [expr $yperfect -3] -fill firebrick3  -tags pointsES
  $w.frame10.picture create line $xauxi 10 $xauxi 15 -tags pointsES
}
set stickY [expr (-$ymin)/5]

$w.frame10.picture create text 20 15 -text [format "%.2f" 0] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 215 -text [format "%.2f" [expr $ymin+$stickY]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 165 -text [format "%.2f" [expr $ymin+[expr $stickY*2]]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 115 -text [format "%.2f" [expr $ymin+[expr $stickY*3]]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 65 -text [format "%.2f" [expr $ymin+[expr $stickY*4]]] -font {Helvetica -9} -tags coordES
$w.frame10.picture create text 20 265 -text [format "%.2f" $ymin] -font {Helvetica -9} -tags coordES
##THE END##
}

proc ddt_tk {} {
  return [ddtGUI]
}

proc WD_setting {} {
variable myvariable
  if {$myvariable != ""} {
     cd $myvariable
  }
}
