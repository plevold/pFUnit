#include "reflection.h"
module Test_RobustRunner_mod
   use Test_mod
   use RobustRunner_mod
   implicit none
   private

   public :: suite

contains

   function suite()
      use TestSuite_mod, only: TestSuite, newTestSuite
      use TestMethod_mod, only: newTestMethod
      type (TestSuite) :: suite

      suite = newTestSuite('StringConversionUtilities')
#define ADD(method) call suite%addTest(newTestMethod(REFLECT(method)))

      ADD(testRunVariety)

   end function suite

   subroutine testRunVariety()
      use iso_fortran_env
      use robustTestSuite_mod, only: remoteSuite => suite
      use SerialContext_mod, only: THE_SERIAL_CONTEXT
      use TestSuite_mod
      use TestResult_mod
      use Assert_mod
      use TestListener_mod
      use ResultPrinter_mod

      type (RobustRunner) :: runner
      type (TestSuite) :: suite
      type (TestResult) :: result
      !mlr -problem on intel 13- type (ListenerPointer) :: listeners1(1)
      type (ListenerPointer), allocatable :: listeners1(:)
      ! class (ListenerPointer), allocatable :: listeners1(:)

      integer :: unit

      allocate(listeners1(1))
      open(newunit=unit, access='sequential',form='formatted',status='scratch')
      allocate(listeners1(1)%pListener, source=newResultPrinter(unit))
      runner = RobustRunner('./tests/remote.x', listeners1)
      result = newTestResult()
      suite = remoteSuite()
      call runner%runWithResult(suite, THE_SERIAL_CONTEXT, result)

      call assertEqual(4, result%runCount(),'runCount()')
      call assertEqual(1, result%failureCount(), 'failureCount()')
      call assertEqual(2, result%errorCount(), 'errorCount()')

      close(unit)

   end subroutine testRunVariety

end module Test_RobustRunner_mod
