/* File:      tables.h
** Author(s): Johnson, Swift, Sagonas, Rao, Freire
** Contact:   xsb-contact@cs.sunysb.edu
** 
** Copyright (C) The Research Foundation of SUNY, 1986, 1993-1998
** 
** XSB is free software; you can redistribute it and/or modify it under the
** terms of the GNU Library General Public License as published by the Free
** Software Foundation; either version 2 of the License, or (at your option)
** any later version.
** 
** XSB is distributed in the hope that it will be useful, but WITHOUT ANY
** WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
** FOR A PARTICULAR PURPOSE.  See the GNU Library General Public License for
** more details.
** 
** You should have received a copy of the GNU Library General Public License
** along with XSB; if not, write to the Free Software Foundation,
** Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
**
** $Id: tables.h,v 1.1 2003-01-20 19:32:16 mthome Exp $
** 
*/


#ifndef __TABLES_H__

#define __TABLES_H__


/*===========================================================================*/

/*
 *                    Tabling Function Prototypes
 *                    ===========================
 */

void	table_call_search(TabledCallInfo *, CallLookupResults *);
BTNptr	table_answer_search(VariantSF, int, int, CPtr, xsbBool *);
void	table_consume_answer(BTNptr, int, int, CPtr, TIFptr);
ALNptr	table_identify_relevant_answers(SubProdSF, SubConsSF, CPtr);
void	table_complete_entry(VariantSF);

void	release_all_tabling_resources(void);


/*
 * The next answer to consume is obtained from the old answer continuation.
 * The new answer continuation is the old continuation but with this answer
 * removed.
 */

#define table_pending_answer( OldAnswerContinuation,			\
			      NewAnswerContinuation,			\
			      NextAnswer,				\
			      Consumer,					\
			      Producer,					\
			      AnswerTemplate,				\
			      PreIdentificationOp,			\
			      PostIdentificationOp ) {			\
			   						\
   NewAnswerContinuation = ALN_Next(OldAnswerContinuation);		\
									\
   if ( IsNULL(NewAnswerContinuation) && IsProperlySubsumed(Consumer) )	\
     if ( MoreAnswersAreAvailable(Consumer,Producer) ) {		\
       PreIdentificationOp;						\
       NewAnswerContinuation =						\
	 table_identify_relevant_answers(Producer, Consumer,		\
					 AnswerTemplate);		\
       PostIdentificationOp;						\
     }									\
   if ( IsNonNULL(NewAnswerContinuation) )				\
     NextAnswer = ALN_Answer(NewAnswerContinuation);			\
   else									\
     NextAnswer = NULL;							\
 }


/*
 * Used as an argument to table_pending_answer() when no pre- or post-
 * identification operation is required.
 */

#define TPA_NoOp


/*
 * Determines whether a producer subgoal has added answers to its set
 * since the given consumer last collected relevant answers from that set.
 */

#define MoreAnswersAreAvailable(ConsSF,ProdSF)			\
   ( IsNonNULL(subg_ans_root_ptr(ProdSF)) &&			\
     (TSTN_TimeStamp((TSTNptr)subg_ans_root_ptr(ProdSF)) >	\
      conssf_timestamp(ConsSF)) )


/*===========================================================================*/


#endif
