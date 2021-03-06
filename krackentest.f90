      program krackentest
      use M_kracken

! call with an arbitrary verb name and a string that defines
! allowable switch names and default values

      call kracken('mycommand',&
     &' -i 10 -r 200.3 -par1 "#N#" -par2 -par3 10 20 30 -files ')

! that's it. Now you can just retrieve the values as strings
! using names of the form VERB_SWITCHNAME anywhere in your program
! the special name VERB_oo is for the string before a switch

      call samples()
      end
!=======================================================================--------
     
! Getting a string with a multi-word default and splitting it from -par3
      call listem('mycommand_par3','-par3',.true.)

! a list of files
      call listem('mycommand_files','-files',.false.)

      end
!=======================================================================--------
      subroutine listem(keyword,label,toreal)
      use M_kracken
!     Just getting fancy and showing the use of DELIM()
!     SAMPLE that decomposes list of strings and optionally, numbers
!     and prints it.
!     delimit with space, comma, or colon
      logical toreal
      character*(*) keyword
      character*(*) label
      character*255 value

!     for DELIM call if you want to break down a list
      character*255 array(132)
      integer ibegin(132)
      integer iterm(132)

!     get the value of the keyword and the length
      call retrev(keyword,value,len,ier)
      write(*,*)'value for ',label,'=',value(:len)
!     split the list into one word per array
      call delim(value,array,132,igot,ibegin,iterm,ilen,' ,:')
!     convert each word into a numeric value
      do i10=1,igot
         write(*,*)i10,') ',array(i10)(:len_trim(array(i10)))
         if(toreal)then
            call string_to_real(array(i10),anumber,ier)
            if(ier.eq.0)then
               write(*,*)' which is a number'
            else
               write(*,*) ' which is not a number'
            endif
         endif
      enddo
      return
      end
!=======================================================================--------
