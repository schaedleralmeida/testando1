!=======================================================================--------
!()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()()
!=======================================================================--------
program krackentest2

   use M_kracken
   implicit none
   character(len=255) :: filename
   integer :: ival
   logical :: lval
   real    :: rval

   
   real    :: rvaleeee
   
   
   integer :: iflen
   integer :: ier
   
!  define the command options and default values and apply arguments from user command line
   call kracken("cmd", " -i 10 -r 10e3 -l ""#N#"" -f input &
!  common versions of help switch
   & -h .F. -help .F.    & 
!  common versions of version switch
   & -v .F. -version .F. & 
   &")
!
!----------------------------------------------------------------------------------------
!  handle version and help requests allowing most common variants
   call help_version()
!----------------------------------------------------------------------------------------
!  get the values specified on the command line
   call retrev("cmd_f",filename,iflen,ier)  ! get -f FILENAME
   lval = lget("cmd_l")                     ! get -l present?
   rval = rget("cmd_r")                     ! get -r RVAL
   ival = iget("cmd_i")                     ! get -i INTEGER
!----------------------------------------------------------------------------------------
   print *, "filename=",filename(:iflen)
   print *, "i=",ival
   print *, "r=",rval
   print *, "l=",lval

   call retrev("cmd_oo",filename,iflen,ier) ! verb shows on ifort, does not on g95
   print *, "cmd_oo=",filename(:iflen)

   call get_command_argument(0,filename)
   print *, "arg(0)=",filename(:len_trim(filename))

!  ANOTHER STRING EXAMPLE
   filename=sget('cmd_f')
   filename= "ooo"
   write(*,*)'filename=',filename(:len_trim(filename))
end program krackentest2
!----------------------------------------------------------------------------------------
   subroutine help_version() ! @(#)  handle version and help requests allowing most common variants
!  just about every program should handle --version and --help options the same

!quero ver como isso funciona mesemo 

   use M_kracken
   implicit none
   logical :: help
   logical :: version

   help=lget('cmd_h')                              ! see if help flag was specified
   if(.not.help) help=lget('cmd_help')
   version=lget('cmd_v')                           ! see if version number request was specified
   if(.not.version) version=lget('cmd_version')
   if(version)then
      write(*,*)'*TESTIT* Version 1-A'
      stop
   endif
   if(help)then
      write(*,*)' cmd '
      write(*,*)' [-i ANY_INTEGER_VALUE]  # default value = 10'
      write(*,*)' [-r ANY_REAL_VALUE]     # default_value= 1000'
      write(*,*)' [-l LOGICAL_VALUE]      # default_value=.F.'
      write(*,*)' [-f FILENAME]           # default_value="input"'
      write(*,*)' [-h|-help|--help]|      # help flag=.F.'
      write(*,*)' [-v|-version|--version] # version flag=.F.'
      write(*,*)''
      stop
   endif
   end subroutine help_version
!----------------------------------------------------------------------------------------
