#   MSVC_mkfile.mak:  Makefile to compile XSB on Windows using VC++ NMAKE
#   Generated automatically from MSVC_mkfile.in by configure.
#
# Usage:
#   NMAKE /f "MS_VC_Mfile.mak" CFG="option" [DLL="yes"] [ORACLE="yes"] [SITE_LIBS="addl libs"]
#
# Where: CFG = release | debug
#    	 DLL = yes: build as a DLL
#        ORACLE=yes: build with support for Oracle
#        SITE_LIBS=<...> : additional loader libraries (required for Oracle
#                          and/or InterProlog)
#
# Note: Specifying any non-zero string for INTERPROLOGSRC and ORACLE means "yes"!
#       Anything different than "no" for DLL means "yes".
#


!IF "$(CFG)" == ""
CFG=release
!ENDIF 

!IF "$(CFG)" != "release" && "$(CFG)" != "debug"
!MESSAGE Invalid configuration "$(CFG)" specified.
!MESSAGE You can specify a configuration when running NMAKE on this makefile
!MESSAGE by defining the macro CFG on the command line.  For example:
!MESSAGE 
!MESSAGE NMAKE /f "MS_VC_Mfile.mak" CFG="debug"
!MESSAGE 
!MESSAGE Possible choices for configuration (CFG) are:
!MESSAGE 
!MESSAGE "release"
!MESSAGE "debug"
!MESSAGE ""  (defaults to "release")
!MESSAGE 
!ERROR An invalid configuration is specified.
!ENDIF 

!IF "$(DLL)" != "yes" && "$(DLL)" != "no" && "$(DLL)" != ""
!MESSAGE Invalid macro DLL="$(DLL)" specified.
!MESSAGE This macro controls whether you want XSB to be built as a DLL.
!MESSAGE For example:
!MESSAGE 
!MESSAGE NMAKE /f "MS_VC_Mfile.mak" CFG="debug" DLL="yes"
!MESSAGE 
!MESSAGE Possible choices for the DLL macro are:
!MESSAGE 
!MESSAGE "yes"
!MESSAGE "no"
!MESSAGE ""
!MESSAGE 
!ERROR An invalid value for the DLL macro specified.
!ENDIF 

!IF "$(ORACLE)" != "yes" && "$(ORACLE)" != "no" && "$(ORACLE)" != ""
!MESSAGE Invalid macro ORACLE="$(ORACLE)" specified.
!MESSAGE This macro controls whether you want XSB to be built
!MESSAGE with support for ORACLE. For example:
!MESSAGE 
!MESSAGE NMAKE /f "MS_VC_Mfile.mak" CFG="release" && ORACLE="yes"
!MESSAGE 
!MESSAGE Possible choices for the ORACLE macro are:
!MESSAGE 
!MESSAGE "yes"
!MESSAGE "no"
!MESSAGE ""
!MESSAGE 
!ERROR An invalid value for the ORACLE macro specified.
!ENDIF 

!IF "$(CALLCONV)" != "cdecl" && "$(CALLCONV)" != "stdcal" && "$(CALLCONV)" != ""
!MESSAGE Invalid value for option CALLCONV specified.
!MESSAGE This option controls the calling convention used for 
!MESSAGE the XSB DLL and foreign-language predicates
!MESSAGE
!MESSAGE Valid choices are:
!MESSAGE "cdecl"  -> use the C language parameter passing convention
!MESSAGE "stdcal" -> use the WINDOWS API native calling convention
!MESSAGE
!ERROR Invalid value for CALLCONV specified.
!ENDIF 

!IF "$(DLL)" == ""
DLL=yes
!ENDIF

!IF "$(CALLCONV)" == ""
CALLCONV=stdcal
!ENDIF

!IF "$(ORACLE)" == ""
ORACLE=no
!ENDIF

!IF "$(OS)" == "Windows_NT"
NULL=
!ELSE 
NULL=nul
!ENDIF 

################################################################################
# Begin Project
CPP=cl.exe

CONFIGDIR=..\config\x86-pc-windows
CONFIG_INCLUDE_FLAG=/I"$(CONFIGDIR)"

# Assume we are running NMAKE in the emu directory
#!IF  "$(DLL)" == "yes"
# Put DLL in the bin directory
DLLDIR=$(CONFIGDIR)\bin
OUTDIR=$(CONFIGDIR)\bin
#!ELSE
#OUTDIR=$(CONFIGDIR)\bin
#!ENDIF

OBJDIR=$(CONFIGDIR)\saved.o

INTDIR=.

!IF "$(CALLCONV)" == "cdecl"
CALL_CONV=XSB_DLL_C
!ELSE
CALL_CONV=XSB_DLL
!ENDIF

!IF  "$(ORACLE)" == "yes"
ORACLE_FLAG=/D "ORACLE"
ORACLE_MSG=with Oracle support
!IF  "$(SITE_LIBS)" == ""
!MESSAGE Oracle libraries must be specified, if building XSB with support for Oracle
!MESSAGE Usage:
!ERROR NMAKE /f "MS_VC_Mfile.mak" CFG="..." ORACLE=yes SITE_LIBS="oracle libs"
!ENDIF
!ENDIF

INTERPROLOGSRC=interprolog_callback.c
JAVA_HEADER_PATH= /IC:\xsbsys\XSBENV\jdk\include /IC:\xsbsys\XSBENV\jdk\include\win32

!IF  "$(INTERPROLOGSRC)" != ""
INTERPRLOG_FLAG=/D "XSB_INTERPROLOG"
INTERPROLOG_MSG=with Interprolog support
CONFIG_INCLUDE_FLAG=$(CONFIG_INCLUDE_FLAG) $(JAVA_HEADER_PATH)

#!IF  "$(SITE_LIBS)" == ""
#!MESSAGE Paths to Java header file must be specified, if building XSB with support for Interprolog using the MSVC compiler
#!MESSAGE Usage:
#!ERROR NMAKE /f "MS_VC_Mfile.mak" CFG="..." INTERPROLOG=1 SITE_LIBS="interprolog libs"
#!ENDIF
!ENDIF

!IF "$(DLL)" == "yes"
ALL : "$(DLLDIR)\xsb.dll" "$(OUTDIR)\xsb.exe"
!ELSE
ALL : "$(OUTDIR)\xsb.exe"
!ENDIF

SOCKET_LIBRARY=wsock32.lib

CLEAN : 
	-@erase "$(OBJDIR)\auxlry.obj"
	-@erase "$(OBJDIR)\biassert.obj"
	-@erase "$(OBJDIR)\builtin.obj"
	-@erase "$(OBJDIR)\cinterf.obj"
	-@erase "$(OBJDIR)\chat.obj"
	-@erase "$(OBJDIR)\dis.obj"
	-@erase "$(OBJDIR)\dynload.obj"
	-@erase "$(OBJDIR)\dynamic_stack.obj"
	-@erase "$(OBJDIR)\emuloop.obj"
	-@erase "$(OBJDIR)\findall.obj"
	-@erase "$(OBJDIR)\function.obj"
	-@erase "$(OBJDIR)\hash_xsb.obj"
	-@erase "$(OBJDIR)\hashtable_xsb.obj"
	-@erase "$(OBJDIR)\heap_xsb.obj"
	-@erase "$(OBJDIR)\inst_xsb.obj"
	-@erase "$(OBJDIR)\init_xsb.obj"
	-@erase "$(OBJDIR)\interprolog_callback.obj"
	-@erase "$(OBJDIR)\io_builtins_xsb.obj"
	-@erase "$(OBJDIR)\loader_xsb.obj"
	-@erase "$(OBJDIR)\main_xsb.obj"
	-@erase "$(OBJDIR)\memory_xsb.obj"
	-@erase "$(OBJDIR)\orastuff.obj"
	-@erase "$(OBJDIR)\orient_xsb.obj"
	-@erase "$(OBJDIR)\psc_xsb.obj"
	-@erase "$(OBJDIR)\private_builtin.obj"
	-@erase "$(OBJDIR)\random_xsb.obj"
	-@erase "$(OBJDIR)\remove_unf.obj"
	-@erase "$(OBJDIR)\residual.obj"
	-@erase "$(OBJDIR)\scc_xsb.obj"
	-@erase "$(OBJDIR)\slgdelay.obj"
	-@erase "$(OBJDIR)\struct_manager.obj"
	-@erase "$(OBJDIR)\storage_xsb.obj"
	-@erase "$(OBJDIR)\sub_delete.obj"
	-@erase "$(OBJDIR)\subp.obj"
	-@erase "$(OBJDIR)\system_xsb.obj"
	-@erase "$(OBJDIR)\table_stats.obj"
	-@erase "$(OBJDIR)\tables.obj"
	-@erase "$(OBJDIR)\timer_xsb.obj"
	-@erase "$(OBJDIR)\token_xsb.obj"
	-@erase "$(OBJDIR)\trace_xsb.obj"
	-@erase "$(OBJDIR)\trie_lookup.obj"
	-@erase "$(OBJDIR)\trie_search.obj"
	-@erase "$(OBJDIR)\tries.obj"
	-@erase "$(OBJDIR)\tr_utils.obj"
	-@erase "$(OBJDIR)\tst_insert.obj"
	-@erase "$(OBJDIR)\tst_retrv.obj"
	-@erase "$(OBJDIR)\tst_unify.obj"
	-@erase "$(OBJDIR)\tst_utils.obj"
	-@erase "$(OBJDIR)\pathname_xsb.obj"
	-@erase "$(OBJDIR)\odbc_xsb.obj"
	-@erase "$(OBJDIR)\error_xsb.obj"
	-@erase "$(OBJDIR)\socket_xsb.obj"
	-@erase "$(OBJDIR)\string_xsb.obj"
	-@erase "$(OBJDIR)\varstring.obj"

"$(OUTDIR)" :
    if not exist "$(OUTDIR)/$(NULL)" mkdir "$(OUTDIR)"

CPP_OBJS=$(OBJDIR)/
CPP_SBRS=
LINK32=link.exe
DLL_LINK32_OBJS= \
	"$(OBJDIR)/auxlry.obj" \
	"$(OBJDIR)/builtin.obj" \
	"$(OBJDIR)/biassert.obj" \
	"$(OBJDIR)/cinterf.obj" \
	"$(OBJDIR)/debug_xsb.obj" \
	"$(OBJDIR)/dis.obj" \
	"$(OBJDIR)/dynload.obj" \
	"$(OBJDIR)/dynamic_stack.obj" \
	"$(OBJDIR)/emuloop.obj" \
	"$(OBJDIR)/error_xsb.obj" \
	"$(OBJDIR)/findall.obj" \
	"$(OBJDIR)/function.obj" \
	"$(OBJDIR)/hash_xsb.obj" \
	"$(OBJDIR)/hashtable_xsb.obj" \
	"$(OBJDIR)/heap_xsb.obj" \
	"$(OBJDIR)/init_xsb.obj" \
	"$(OBJDIR)/inst_xsb.obj" \
	"$(OBJDIR)/io_builtins_xsb.obj" \
	"$(OBJDIR)/loader_xsb.obj" \
	"$(OBJDIR)/memory_xsb.obj" \
	"$(OBJDIR)/odbc_xsb.obj" \
	"$(OBJDIR)/orient_xsb.obj" \
	"$(OBJDIR)/pathname_xsb.obj" \
	"$(OBJDIR)/psc_xsb.obj" \
	"$(OBJDIR)/private_builtin.obj" \
	"$(OBJDIR)/random_xsb.obj" \
	"$(OBJDIR)/remove_unf.obj" \
	"$(OBJDIR)/residual.obj" \
	"$(OBJDIR)/scc_xsb.obj" \
	"$(OBJDIR)/slgdelay.obj" \
	"$(OBJDIR)/struct_manager.obj" \
	"$(OBJDIR)/storage_xsb.obj" \
	"$(OBJDIR)/sub_delete.obj" \
	"$(OBJDIR)/subp.obj" \
	"$(OBJDIR)/system_xsb.obj" \
	"$(OBJDIR)/table_stats.obj" \
	"$(OBJDIR)/tables.obj" \
	"$(OBJDIR)/timer_xsb.obj" \
	"$(OBJDIR)/token_xsb.obj" \
	"$(OBJDIR)/trace_xsb.obj" \
	"$(OBJDIR)/trie_lookup.obj" \
	"$(OBJDIR)/trie_search.obj" \
	"$(OBJDIR)/tries.obj" \
	"$(OBJDIR)/tr_utils.obj" \
	"$(OBJDIR)/tst_insert.obj" \
	"$(OBJDIR)/tst_retrv.obj" \
	"$(OBJDIR)/tst_unify.obj" \
	"$(OBJDIR)/tst_utils.obj" \
	"$(OBJDIR)/socket_xsb.obj" \
	"$(OBJDIR)/string_xsb.obj" \
	"$(OBJDIR)/varstring.obj"

# DLLs don't use main_xsb.c
!IF  "$(DLL)" == "no"
LINK32_OBJS=$(DLL_LINK32_OBJS) $(OBJDIR)/main_xsb.obj
!ELSE
LINK32_OBJS=$(OBJDIR)/main_xsb.obj
!ENDIF

# Oracle requires one additional file
!IF "$(ORACLE)" == "yes"
!IF "$(DLL)" == "yes"
DLL_LINK32_OBJS=$(DLL_LINK32_OBJS) $(OBJDIR)/orastuff.obj
!ELSE
LINK32_OBJS=$(LINK32_OBJS) $(OBJDIR)/orastuff.obj
!ENDIF
!ENDIF

# Interprolog requires one additional file
!IF "$(INTERPROLOGSRC)" != ""
!IF "$(DLL)" == "yes"
DLL_LINK32_OBJS=$(DLL_LINK32_OBJS) $(OBJDIR)/interprolog_callback.obj
!ELSE
LINK32_OBJS=$(LINK32_OBJS) $(OBJDIR)/interprolog_callback.obj
!ENDIF
!ENDIF

!IF  "$(CFG)" == "release"  &&  "$(DLL)" == "no"
!MESSAGE Building XSB executable in Release mode $(ORACLE_MSG) $(INTERPROLOG_MSG)

CPP_PROJ=/nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"\
 $(CONFIG_INCLUDE_FLAG) $(ORACLE_FLAG) $(INTERPROLOG_FLAG)\
  /Fp"$(OBJDIR)/xsb.pch" /YX /Fo"$(OBJDIR)/" /c 

LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib $(SOCKET_LIBRARY) "$(SITE_LIBS)" /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)/xsb.pdb" /machine:I386 \
 /out:"$(OUTDIR)/xsb.exe" 


!ELSEIF  "$(CFG)" == "debug"  &&  "$(DLL)" == "no"
!MESSAGE Building XSB executable in Debug mode $(ORACLE_MSG) $(INTERPROLOG_MSG)

CPP_PROJ=/nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "DEBUG" $(CONFIG_INCLUDE_FLAG) $(ORACLE_FLAG) $(INTERPRLOG_FLAG)\
  /Fp"$(OBJDIR)/xsb.pch" /YX /Fo"$(OBJDIR)/" /Fd"$(INTDIR)/" /c 
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib $(SOCKET_LIBRARY) "$(SITE_LIBS)" /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)/xsb.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\xsb.exe" 


!ELSEIF "$(CFG)" == "release" && "$(DLL)" == "yes"
!MESSAGE Building XSB as a DLL in Release mode $(ORACLE_MSG) $(INTERPROLOG_MSG)

CPP_PROJ=/nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_CONSOLE"\
 /D "$(CALL_CONV)" $(CONFIG_INCLUDE_FLAG) $(ORACLE_FLAG) $(INTERPROLOG_FLAG)\
  /Fp"$(OBJDIR)/xsb.pch" /YX /Fo"$(OBJDIR)/" /c 
DLL_CPP_PROJ=/nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS"\
  /D "$(CALL_CONV)" $(CONFIG_INCLUDE_FLAG) $(ORACLE_FLAG)$(INTERPROLOG_FLAG)\
   /Fp"$(OBJDIR)/xsb.pch" /YX /Fo"$(OBJDIR)/" /c 
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib $(SOCKET_LIBRARY) "$(SITE_LIBS)" $(DLLDIR)"\xsb.lib"\
 /nologo /subsystem:console /incremental:no\
 /pdb:"$(OUTDIR)/xsb.pdb" /machine:I386 \
 /out:"$(OUTDIR)/xsb.exe" 
DLL_LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib $(SOCKET_LIBRARY) "$(SITE_LIBS)" \
 /nologo /subsystem:windows /dll /incremental:no\
 /pdb:"$(DLLDIR)/xsb.pdb" /machine:I386 /out:"$(DLLDIR)/xsb.dll"\
 /implib:"$(DLLDIR)/xsb.lib" 

!ELSEIF "$(CFG)" == "debug" &&  "$(DLL)" == "yes"
!MESSAGE Building XSB as a DLL in Debug mode $(ORACLE_MSG) $(INTERPROLOG_MSG)

DLL_CPP_PROJ=/nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG"\
 /D "_WINDOWS"\ /D "DEBUG" $(CONFIG_INCLUDE_FLAG) $(ORACLE_FLAG) $(INTERPROLOG_FLAG)\
  /D "$(CALL_CONV)" /Fp"$(OBJDIR)/xsb.pch" /YX\
 /Fo"$(OBJDIR)/" /Fd"$(INTDIR)/" /c 

DLL_LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib $(SOCKET_LIBRARY) "$(SITE_LIBS)" /nologo /subsystem:windows /dll /incremental:yes\
 /pdb:"$(DLLDIR)/xsb.pdb" /debug /machine:I386\
 /out:"$(DLLDIR)\xsb.dll"\
 /implib:"$(DLLDIR)/xsb.lib"	 
CPP_PROJ=/nologo /MTd /W3 /Gm /GX /Zi /Od /D "WIN32" /D "_DEBUG" /D "_CONSOLE"\
 /D "DEBUG" $(CONFIG_INCLUDE_FLAG) $(ORACLE_FLAG) $(INTERPROLOG_FLAG) /D "$(CALL_CONV)" \
  /Fp"$(OBJDIR)/xsb.pch" /YX /Fo"$(OBJDIR)/" /Fd"$(INTDIR)/" /c 
LINK32_FLAGS=kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib\
 advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib\
 odbccp32.lib $(SOCKET_LIBRARY) "$(SITE_LIBS)" $(DLLDIR)"\xsb.lib"\
 /nologo /subsystem:console /incremental:yes\
 /pdb:"$(OUTDIR)/xsb.pdb" /debug /machine:I386\
 /out:"$(OUTDIR)\xsb.exe" 

!ENDIF 


"$(OUTDIR)\xsb.exe" : "$(OBJDIR)" $(DEF_FILE) $(LINK32_OBJS)
    $(LINK32) @<<
  $(LINK32_FLAGS) $(LINK32_OBJS)
<<

"$(DLLDIR)\xsb.dll" : "$(DLLDIR)" $(DEF_FILE) $(DLL_LINK32_OBJS)
    $(LINK32) @<<
  $(DLL_LINK32_FLAGS) $(DLL_LINK32_OBJS)
<<

.c{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_OBJS)}.obj:
   $(CPP) $(CPP_PROJ) $<  

.c{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cpp{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  

.cxx{$(CPP_SBRS)}.sbr:
   $(CPP) $(CPP_PROJ) $<  


# Local Variables:
# coding-system-for-write: iso-2022-7bit-dos
# End:
